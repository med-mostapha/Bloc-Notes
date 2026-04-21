import 'package:bloc_notes/models/note.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  final Note? noteToEdit;
  const CreatePage({super.key, this.noteToEdit});
  @override
  State<CreatePage> createState() => _CreateState();
}

class _CreateState extends State<CreatePage> {
  final GlobalKey<FormState> formstate = GlobalKey<FormState>();

  final TextEditingController _titreController = TextEditingController();
  final TextEditingController _contenuController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.noteToEdit != null) {
      _titreController.text = widget.noteToEdit!.titre;
      _contenuController.text = widget.noteToEdit!.contenu;
    }
  }

  @override
  void dispose() {
    _titreController.dispose();
    _contenuController.dispose();
    super.dispose();
  }

  void _CreateNote() {
    if (formstate.currentState!.validate()) {
      final newNote = Note(
        id: DateTime.now().toString(),
        titre: _titreController.text.trim(),
        contenu: _contenuController.text.trim(),
        dateCreation: DateTime.now(),
      );

      Navigator.pop(context, newNote);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.noteToEdit != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(isEditing ? "Update" : "Create"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 22),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formstate,
          // padding: EdgeInsets.all(10),
          child: Column(
            children: [
              // title
              TextFormField(
                decoration: InputDecoration(labelText: "title"),
                controller: _titreController,
                validator: (titre) {
                  if (titre == null || titre.isEmpty) {
                    return "Title is required";
                  }
                  if (titre.length < 3) return "Min 3 letter";
                  return null;
                },
              ),

              SizedBox(height: 10),

              // contenu
              TextFormField(
                decoration: InputDecoration(labelText: "contenu"),
                controller: _contenuController,
                validator: (contenu) {
                  if (contenu == null || contenu.isEmpty) {
                    return "Contenu is required";
                  }
                  if (contenu.length < 5) return "Min 5 letter";
                  return null;
                },
              ),

              SizedBox(height: 20),

              MaterialButton(
                onPressed: () => _CreateNote(),
                minWidth: 300,
                textColor: Colors.white,
                color: Colors.deepPurple,
                child: Text(isEditing ? "Update" : "Create"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
