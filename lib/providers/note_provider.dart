import 'package:flutter/material.dart';
import '../models/note.dart';
import '../data/note_repository.dart';
import '../data/local_note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final NoteRepository _repository = LocalNoteRepository();

  List<Note> _notes = [];

  List<Note> get notes => _notes;

  NoteProvider() {
    loadNotes();
  }

  Future<void> loadNotes() async {
    _notes = await _repository.getNotes();
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    await _repository.addNote(note);
    await loadNotes();
  }

  Future<void> updateNote(String id, Note note) async {
    await _repository.updateNote(id, note);
    await loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await _repository.deleteNote(id);
    await loadNotes();
  }
}
