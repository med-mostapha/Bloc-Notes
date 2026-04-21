import 'package:bloc_notes/models/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 226, 226, 226),
            blurRadius: 10,
            spreadRadius: 1,
            offset: Offset(1, 4),
          ),
        ],
      ),
      child: ListTile(
        minLeadingWidth: 10,

        title: Text(note.titre, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          note.contenu.length > 30
              ? note.contenu.substring(0, 30)
              : note.contenu,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
