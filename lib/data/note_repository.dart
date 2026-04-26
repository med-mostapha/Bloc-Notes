import 'package:bloc_notes/models/note.dart';

abstract class NoteRepository {
  Stream<List<Note>> watchNotes();

  Future<void> addNote(Note note);

  Future<void> updateNote(String id, Note note);

  Future<void> deleteNote(String id);
}
