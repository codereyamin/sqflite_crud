import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud/models/nodes/node.dart';

import '../../logic/home_screen/home_screen_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeScreenController(), /////// home controller initialing call
        builder: (context) {
          return Scaffold(
            ////////// app bar
            appBar: AppBar(
              title: const Text("Sqflite CRUD"),
              centerTitle: true,
            ),
            /////// add button
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller
                    .bottomSheetDialog(); ///// click this button call bottom sheet
              },
              backgroundColor: Colors.indigoAccent,

              ////////// button icon
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),

            body: Obx(
              () => controller
                      .myNotes.isEmpty //////////// check notes list is empty
                  ? const SizedBox() ////// notes list is empty simply sized box
                  //////////////// notes list not empty
                  /////////////// show list with animation
                  : AnimatedList(
                      initialItemCount: controller
                          .myNotes.length, ///////// initial list length provide
                      key: controller.homeAnimationKey, ////////// provide key
                      itemBuilder: (context, index, animation) {
                        Note note =
                            controller.myNotes[index]; ////////// split one note
                        return buildItem(animation, note,
                            index); ///////// list item return with note, animation, index
                      },
                    ),
            ),
          );
        });
  }

  ////////////// create list item build function
  ///
  Padding buildItem(Animation<double> animation, Note myNotes, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0), ////////// space make per item
      child: SizeTransition(
          sizeFactor: animation,
          key: UniqueKey(),
          child: Card(
            elevation: 5,
            child: ListTile(
              title: Text(myNotes.title.toString()),
              subtitle: Text(myNotes.mobileNumber.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      ////////////// call bottom sheet to edit existing note
                      controller.bottomSheetDialog(
                          isAdd: false,
                          note: myNotes,
                          id: myNotes
                              .id, ////// provide necessary all data to edit or update
                          index: index);
                    },
                    icon: const Icon(Icons.edit), ///////// edit icon
                  ),
                  IconButton(
                    onPressed: () async {
                      ////////////// call note remove or delete function
                      await controller.removeNote(
                          index: index, id: myNotes.id!);
                      ////////////// ui update using animation
                      controller.homeAnimationKey.currentState?.removeItem(
                        index,
                        (context, animation) => buildItem(animation, myNotes,
                            index), ////////// recall build method smooth animation remove show
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent, /////////// remove or delete icon
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
