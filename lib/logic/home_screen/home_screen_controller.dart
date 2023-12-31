import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../core/data_base/data_base_helper.dart';
import '../../models/nodes/node.dart';

class HomeScreenController extends GetxController {
  /////////// Define all text editing controller
  late TextEditingController nameController = TextEditingController();
  late TextEditingController numberController = TextEditingController();

  /////////// Define all key controller
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> homeAnimationKey =
      GlobalKey<AnimatedListState>();
///////// all note list
  RxList<Note> myNotes = <Note>[].obs;

  //////// data load crate function
  onloadNote() async {
    /////////// all data fetch function call
    final data = await DatabaseHelper.getNotes();

    /////////// note add  on list
    myNotes.addAll(data);
    ///////// list refresh
    myNotes.refresh();
  }

  ////////// note add data base create function
  addNote() async {
    ///////////// first check form is valid
    if (formKey.currentState!.validate()) {
      //////// form is valid
      ///create note object
      final note = Note(
          title: nameController.text.trim(),
          mobileNumber: numberController.text.trim());
      ////////// data base data  insert function call & parameter note send
      await DatabaseHelper.insertNote(note);

      /////////  ui animation create
      homeAnimationKey.currentState
          ?.insertItem(0, duration: const Duration(milliseconds: 700));
      /////////// note add  on list
      myNotes.add(note);
      ///////// list refresh
      myNotes.refresh();

      /////////// all text editing controller clear
      nameController.clear();
      numberController.clear();

      ///////// bottom sheet close
      Get.back();
    }
  }

//////// remove note create function
  removeNote({required int index, required int id}) async {
    ///// data base data delete & parameter send id
    await DatabaseHelper.deleteNote(id);

    //////// list remove using index
    myNotes.removeAt(index);

    //////// list refresh
    myNotes.refresh();
  }

///////// update note create function
  updateNote({required int index, required int id}) async {
    //////////  create note object
    final note = Note(
      id: id,
      title: nameController.text.trim(),
      mobileNumber: numberController.text.trim(),
    );

    ///////// list assign new note
    myNotes[index] = note;
    //////  bottom sheet off to call
    Get.back();
    ///// refresh list
    myNotes.refresh();
    ////// clear all text editing controller
    nameController.clear();
    numberController.clear();
    //////////// data base update function call with new node
    await DatabaseHelper.updateNote(note);
  }

/////////// bottom sheet create function
  bottomSheetDialog(
      {bool isAdd = true, Note? note, int? id, int? index}) async {
    /////////// first check note has data
    if (note != null) {
      /////// note is not null than assign data to controller
      nameController.text = note.title;
      numberController.text = note.mobileNumber;
    }

    //////// bottom sheet call
    await Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height / 10 * 3.5,
      ////////// some decoration
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Form(
        key: formKey, //////// key assign
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ////////// name field
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Name field is required";
                    }

                    return null;
                  },
                  //////////// field decoration
                  decoration: const InputDecoration(
                    labelText: "User Name",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              ///////  mobile number field
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Mobile number field is required";
                    }
                    if (value.length < 10) {
                      return "Mobile number is not valid";
                    }
                    return null;
                  },
                  //////////// field decoration
                  decoration: const InputDecoration(
                    labelText: "Mobile Number",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.redAccent)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  ///////// check button action type
                  if (isAdd) {
                    /////////// action is add type then add note function call
                    addNote();
                  } else {
                    ////////// action type is update
                    ///than check index & id not null
                    if (index != null && id != null) {
                      ////////// data update function  call
                      updateNote(index: index, id: id);
                    }
                  }
                },

                ///////// button some style
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      color: Colors.blueGrey,
                      width: 5,
                    ),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                  child: Text(
                    isAdd
                        ? "Add"
                        : "Update", /////// show message note update or add
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ]),
      ),
    ));
  }

  @override
  void onInit() {
    /////// page on initializes data fetch call form data base
    onloadNote();
    super.onInit();
  }

  @override
  void onClose() {
    ///////// page close
    ///controller remove
    ///memory free
    nameController.dispose();
    numberController.dispose();
    super.onClose();
  }
}
