import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note.dart';
import 'note_repository.dart';

class FirebaseNoteRepository implements NoteRepository {
  final _collection = FirebaseFirestore.instance.collection('notes');

  @override
  Stream<List<Note>> watchNotes() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Note.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

  @override
  Future<void> addNote(Note note) async {
    await _collection.add(note.toMap());
  }

  @override
  Future<void> updateNote(String id, Note note) async {
    await _collection.doc(id).update(note.toMap());
  }

  @override
  Future<void> deleteNote(String id) async {
    await _collection.doc(id).delete();
  }
}
