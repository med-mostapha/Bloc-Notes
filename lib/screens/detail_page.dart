import 'package:flutter/material.dart';
import 'package:bloc_notes/models/note.dart';
import 'package:bloc_notes/screens/create_page.dart';

class DetailPage extends StatelessWidget {
  final Note note;

  const DetailPage({super.key, required this.note});

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Note"),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedNote = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CreatePage(noteToEdit: note)),
              );

              if (updatedNote != null) {
                Navigator.pop(context, updatedNote);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context, "delete");
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.titre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              "Created: ${formatDate(note.dateCreation)}",
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            Text(note.contenu, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
