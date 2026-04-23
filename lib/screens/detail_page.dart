import 'package:flutter/material.dart';
import 'package:bloc_notes/models/note.dart';

class DetailPage extends StatefulWidget {
  final Note note;

  const DetailPage({super.key, required this.note});
  @override
  State<DetailPage> createState() => _DetailState();
}

class _DetailState extends State<DetailPage> {
  final TextEditingController _contenuController = TextEditingController();
  final TextEditingController _titreController = TextEditingController();

  bool showSaveButton = false;
  String oldMessage = "";
  String oldTitre = "";

  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  void initState() {
    super.initState();
    oldMessage = widget.note.contenu;
    _contenuController.text = oldMessage;

    oldTitre = widget.note.titre;
    _titreController.text = oldTitre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Note"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple,
        actions: showSaveButton
            ? [
                IconButton(
                  onPressed: () {
                    final updatedNote = Note(
                      id: widget.note.id,
                      titre: widget.note.titre,
                      contenu: _contenuController.text,
                      couleur: widget.note.couleur,
                      dateCreation: widget.note.dateCreation,
                      dateModification: DateTime.now(),
                    );

                    Navigator.pop(context, updatedNote);
                  },
                  icon: Icon(Icons.check),
                ),
              ]
            : [],
      ),

      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Created: ${formatDate(widget.note.dateCreation)}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextField(
              decoration: InputDecoration(
                label: Text("Titre"),
                border: OutlineInputBorder(),
              ),
              controller: _titreController,
            ),

            const SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                label: Text("Contenu"),
                border: OutlineInputBorder(),
              ),
              controller: _contenuController,
              maxLines: 8,
              onChanged: (value) {
                setState(() {
                  showSaveButton = (oldMessage != value);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
