import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  //get collection of notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // CREATE : add a new note
  Future<void> addNewNote(
      String note, String noteTitle, String date, int colorId) {
    return notes.add({
      'note': note,
      'note_title': noteTitle,
      'timestamp': date,
      'color_id': colorId,
    });
  }

  // READ : get notes from database
  Stream<QuerySnapshot> getNotesStream() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();
    // snapshots() is used to create a live stream that reflects changes in the collection based on the defined query.

    return notesStream;
  }

  // UPDATE : update notes from the given doc id

  Future<void> updateNote(String newNote, String docID) {
    return notes
        .doc(docID)
        .update({'note': newNote, 'timestamp': Timestamp.now()});
  }

  // DELETE : delete notes from the given doc id
  Future<void> deleteNote(String docID) {
    return notes.doc(docID).delete();
  }
}
