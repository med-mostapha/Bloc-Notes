import 'package:bloc_notes/models/note.dart';
import 'package:bloc_notes/providers/note_provider.dart';
import 'package:bloc_notes/screens/create_page.dart';
import 'package:bloc_notes/screens/detail_page.dart';
import 'package:bloc_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _deleteNote(BuildContext context, String id) {
    context.read<NoteProvider>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // final List<Note> notes = [];
    final notes = context.watch<NoteProvider>().notes;

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes (${notes.length})"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),

      body: notes.isEmpty
          ? const Center(
              child: Text(
                "Aucune note",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: notes.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final note = notes[index];
                return NoteCard(
                  note: note,

                  // onLongPress: () => _deleteNote(context, note.id),
                  onDelete: () => _deleteNote(context, note.id),

                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailPage(note: note)),
                    );

                    if (result != null && result is Note) {
                      context.read<NoteProvider>().updateNote(
                        notes[index].id,
                        result,
                      );
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
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
