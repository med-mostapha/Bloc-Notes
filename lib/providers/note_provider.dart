import 'dart:async';

import 'package:flutter/material.dart';
import '../models/note.dart';
import '../data/note_repository.dart';

class NoteProvider extends ChangeNotifier {
  final NoteRepository _repository;

  List<Note> _notes = [];
  String? _error;
  bool _isLoading = true;

  List<Note> get notes => _notes;
  String? get error => _error;
  bool get isLoading => _isLoading;

  // for stream cancle
  late StreamSubscription _subscription;

  NoteProvider(this._repository) {
    _subscription = _repository.watchNotes().listen(
      (notes) {
        _notes = notes;
        _isLoading = false;
        notifyListeners();
      },
      onError: (e) {
        _error = e.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  // cancle stream
  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> addNote(Note note) async {
    try {
      await _repository.addNote(note);
    } catch (e) {
      _error = "Failed to add note";
      notifyListeners();
    }
  }

  Future<void> updateNote(String id, Note note) async {
    try {
      await _repository.updateNote(id, note);
    } catch (e) {
      _error = "Failed to update note";
      notifyListeners();
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _repository.deleteNote(id);
    } catch (e) {
      _error = "Failed to delete note";
      notifyListeners();
    }
  }
}
