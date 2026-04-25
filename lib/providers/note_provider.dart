import 'package:flutter/material.dart';
import '../models/note.dart';
import '../data/note_repository.dart';
import '../data/local_note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final NoteRepository _repository = LocalNoteRepository();

  List<Note> _notes = [];
  bool _isLoading = false;
  String? _error;

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  NoteProvider() {
    loadNotes();
  }

  Future<void> loadNotes() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // delete this in production.
      await Future.delayed(const Duration(seconds: 5));

      _notes = await _repository.getNotes();
    } catch (e) {
      _error = "Failed to load notes";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote(Note note) async {
    try {
      await _repository.addNote(note);
      await loadNotes();
    } catch (e) {
      _error = "Failed to add note";
      notifyListeners();
    }
  }

  Future<void> updateNote(String id, Note note) async {
    try {
      await _repository.updateNote(id, note);
      await loadNotes();
    } catch (e) {
      _error = "Failed to update note";
      notifyListeners();
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _repository.deleteNote(id);
      await loadNotes();
    } catch (e) {
      _error = "Failed to delete note";
      notifyListeners();
    }
  }
}
