import 'package:bloc_notes/models/note.dart';
import 'package:bloc_notes/providers/note_provider.dart';
import 'package:bloc_notes/screens/create_page.dart';
import 'package:bloc_notes/screens/detail_page.dart';
import 'package:bloc_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _deleteNote(BuildContext context, int index) {
    context.read<NoteProvider>().deleteNote(index);
  }

  @override
  Widget build(BuildContext context) {
    // final List<Note> notes = [];
    final notes = context.watch<NoteProvider>().notes;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes (${notes.length})"),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: notes.isEmpty
          ? const Center(child: Text("Aucune note"))
          : ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: notes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return NoteCard(
                  note: notes[index],

                  onLongPress: () => _deleteNote(context, index),

                  onEdit: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreatePage(noteToEdit: notes[index]),
                      ),
                    );

                    if (updated != null) {
                      context.read<NoteProvider>().updateNote(index, updated);
                    }
                  },

                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailPage(note: notes[index]),
                      ),
                    );

                    if (result == "delete") {
                      context.read<NoteProvider>().deleteNote(index);
                    } else if (result is Note) {
                      context.read<NoteProvider>().updateNote(index, result);
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          final note = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePage()),
          );

          if (note != null) {
            context.read<NoteProvider>().addNote(note);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
