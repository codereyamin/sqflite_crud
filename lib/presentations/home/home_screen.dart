import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_crud/models/nodes/node.dart';

import '../../logic/home_screen/home_screen_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: HomeScreenController(),
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Sqflite CRUD"),
              centerTitle: true,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.bottomSheetDialog();
              },
              backgroundColor: Colors.indigoAccent,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            body: Obx(
              () => controller.myNotes.isEmpty
                  ? SizedBox()
                  : AnimatedList(
                      initialItemCount: controller.myNotes.length,
                      key: controller.homeAnimationKey,
                      itemBuilder: (context, index, animation) {
                        Note myNotes = controller.myNotes[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizeTransition(
                              sizeFactor: animation,
                              key: UniqueKey(),
                              child: Card(
                                elevation: 5,
                                child: ListTile(
                                  title: Text(myNotes.title.toString()),
                                  subtitle:
                                      Text(myNotes.mobileNumber.toString()),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          controller.bottomSheetDialog(
                                            isAdd: false,
                                            note: myNotes,
                                          );
                                        },
                                        icon: Icon(Icons.edit),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                        );
                      },
                    ),
            ),
          );
        });
  }
}
