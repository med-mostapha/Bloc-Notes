import 'package:bloc_notes/models/note.dart';
import 'package:bloc_notes/providers/note_provider.dart';
import 'package:bloc_notes/screens/create_page.dart';
import 'package:bloc_notes/screens/detail_page.dart';
import 'package:bloc_notes/widgets/note_card.dart';
import 'package:bloc_notes/widgets/skeletons/note_card_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NoteProvider>();
    final notes = provider.notes;

    Widget body;

    if (provider.isLoading) {
      body = ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: 5,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (_, __) => const NoteCardSkeleton(),
      );
    } else if (notes.isEmpty) {
      body = const Center(
        child: Text(
          "Aucune note",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    } else {
      body = ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: notes.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final note = notes[index];
          return NoteCard(
            note: note,
            onDelete: () => context.read<NoteProvider>().deleteNote(note.id),
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailPage(note: note)),
              );
              if (result != null && result is Note) {
                context.read<NoteProvider>().updateNote(note.id, result);
              }
            },
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes (${notes.length})"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: body,
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
