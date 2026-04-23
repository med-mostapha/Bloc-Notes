import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [
    Note(
      id: '1',
      titre: 'Test Note',
      contenu: 'This is a test note',
      couleur: '#FFE082',
      dateCreation: DateTime.now(),
    ),
  ];

  List<Note> get notes => List.unmodifiable(_notes);

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(String id, Note note) {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index] = note;
      notifyListeners();
    }
  }

  void deleteNote(String id) {
    _notes.removeWhere((n) => n.id == id);
    notifyListeners();
  }
}
