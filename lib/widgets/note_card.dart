import 'package:bloc_notes/models/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.onLongPress,
    this.onEdit,
  });

  final Note note;
  final VoidCallback? onEdit;
  final VoidCallback? onLongPress;

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
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.deepPurple),
          onPressed: onEdit,
        ),
        // edit btn
        onLongPress: onLongPress,
        // delete btn
        minLeadingWidth: 10,
        title: Text(note.titre, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          note.contenu.length > 80
              ? note.contenu.substring(0, 80)
              : note.contenu,
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
