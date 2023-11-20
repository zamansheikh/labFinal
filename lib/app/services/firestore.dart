import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  //get data from firestore
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  //create data in firestore
  Future<void> addNote(String title, String description) async {
    return notes
        .add({
          'title': title,
          'description': description,
          'timestamp': Timestamp.now(),
        })
        .then((value) => print("Note Added"))
        .catchError((error) => print("Failed to add note: $error"));
  }

  //READ: get data from firestore
  Stream<QuerySnapshot> getNotes() {
    return notes.orderBy('timestamp', descending: true).snapshots();
  }

  //update data in firestore
  Future<void> updateNote(
      String DocID, String title, String description) async {
    return notes
        .doc(DocID)
        .update({
          'title': title,
          'description': description,
        })
        .then((value) => print("Note Updated"))
        .catchError((error) => print("Failed to update note: $error"));
  }

  //delete data in firestore
  Future<void> deleteNote(
    String DocID,
  ) async {
    return notes
        .doc(DocID)
        .delete()
        .then((value) => print("Note Deleted"))
        .catchError((error) => print("Failed to delete note: $error"));
  }
}
