import 'package:bloc_notes/models/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    super.key,
    required this.note,
    this.onLongPress,
    this.onDelete,
    this.onTap,
  });

  final Note note;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(
            color: Color(int.parse(note.couleur.replaceFirst('#', '0xff'))),
            width: 5,
          ),
        ),
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
          icon: const Icon(Icons.delete, color: Colors.deepPurple),
          onPressed: onDelete,
        ),
        // show dtalis
        onTap: onTap,
        // edit btn
        onLongPress: onLongPress,
        // delete btn
        minLeadingWidth: 10,
        title: Text(note.titre, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(note.contenu, style: TextStyle(color: Colors.grey)),
            SizedBox(height: 4),
            Text(
              "${note.dateCreation.day}/${note.dateCreation.month}/${note.dateCreation.year}",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
