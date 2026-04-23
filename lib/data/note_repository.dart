import 'package:bloc_notes/models/note.dart';

abstract class NoteRepository {
  Future<List<Note>> getNotes();

  Future<void> addNote(Note note);

  Future<void> updateNote(String id, Note note);

  Future<void> deleteNote(String id);
}
