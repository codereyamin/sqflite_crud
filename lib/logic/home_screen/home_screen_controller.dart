import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../models/nodes/node.dart';

class HomeScreenController extends GetxController {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController numberController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<AnimatedListState> homeAnimationKey =
      GlobalKey<AnimatedListState>();
  List<Note> initialNote = <Note>[
    ...List.generate(
      50,
      (index) => Note(title: "tuhin", mobileNumber: "5622545"),
    )
  ];
  RxList<Note> myNotes = <Note>[].obs;

  loadItem() {
    int index = 0;
    Future.delayed(Duration(seconds: 5));
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (initialNote.length == index) {
        timer.cancel();
      } else {
        index++;
        homeAnimationKey.currentState
            ?.insertItem(0, duration: Duration(milliseconds: 100));
        myNotes.add(initialNote[index - 1]);
        myNotes.refresh();
      }
    });
  }

  bottomSheetDialog({bool isAdd = true, Note? note, int? id}) async {
    if (note != null) {
      nameController.text = note.title;
      numberController.text = note.mobileNumber;
    }
    await Get.bottomSheet(Container(
      width: Get.width,
      height: Get.height / 10 * 3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: nameController,
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                onPressed: () {},
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
                    isAdd ? "Add" : "Update",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ]),
      ),
    ));
  }

  @override
  void onInit() {
    loadItem();
    super.onInit();
  }
}
