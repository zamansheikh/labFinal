import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labfinal/app/services/firestore.dart';

class CrudController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final FireStoreService fireStoreService = FireStoreService();
  void openDialog({String? docID}) {
    Get.defaultDialog(
      title: 'Dialog Title',
      content: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Title',
            ),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(
              hintText: 'Description',
            ),
          ),
        ],
      ),
      textConfirm: 'Confirm',
      textCancel: 'Cancel',
      onConfirm: () {
        if (docID == null) {
          fireStoreService.addNote(
            titleController.text,
            descriptionController.text,
          );
        } else {
          fireStoreService.updateNote(
            docID,
            titleController.text,
            descriptionController.text,
          );
        }
        titleController.clear();
        descriptionController.clear();
        Get.back();
      },
      onCancel: () {
        Get.back();
      },
    );
  }

  Future<void> editNote(String docID) async {
    var doc = await fireStoreService.notes.doc(docID).get();
    var title = doc['title'];
    var description = doc['description'];
    titleController.text = title;
    descriptionController.text = description;

    openDialog(docID: docID);
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
