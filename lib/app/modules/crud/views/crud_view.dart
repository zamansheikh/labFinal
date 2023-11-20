import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/crud_controller.dart';

class CrudView extends GetView<CrudController> {
  const CrudView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CrudView'),
          elevation: 0,
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            controller.openDialog();
          },
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: controller.fireStoreService.getNotes(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List notesList = snapshot.data!.docs;
              return ListView.builder(
                itemCount: notesList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot doccumentSnapshot = notesList[index];
                  String docID = doccumentSnapshot.id;

                  return Card(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(notesList[index]['title']),
                            subtitle: Text(notesList[index]['description']),
                            trailing: IconButton(
                              onPressed: () {
                                controller.fireStoreService.deleteNote(
                                  docID,
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.editNote(docID);
                            },
                            icon: const Icon(Icons.edit))
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
