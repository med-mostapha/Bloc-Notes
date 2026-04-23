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

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void updateNote(int index, Note note) {
    _notes[index] = note;
    notifyListeners();
  }

  void deleteNote(int index) {
    _notes.removeAt(index);
    notifyListeners();
  }
}
