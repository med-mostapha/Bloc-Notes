import '../models/note.dart';
import 'note_repository.dart';

class LocalNoteRepository implements NoteRepository {
  final List<Note> _notes = [
    Note(
      id: '1',
      titre: 'Local Note',
      contenu: 'Stored in repository',
      couleur: '#FFE082',
      dateCreation: DateTime.now(),
    ),
  ];

  @override
  Future<List<Note>> getNotes() async {
    return _notes;
  }

  @override
  Future<void> addNote(Note note) async {
    _notes.add(note);
  }

  @override
  Future<void> updateNote(String id, Note note) async {
    final index = _notes.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notes[index] = note;
    }
  }

  @override
  Future<void> deleteNote(String id) async {
    _notes.removeWhere((n) => n.id == id);
  }
}
