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

  String selectedColor = '#FFE082';

  @override
  void initState() {
    super.initState();
    if (widget.noteToEdit != null) {
      _titreController.text = widget.noteToEdit!.titre;
      _contenuController.text = widget.noteToEdit!.contenu;
      selectedColor = widget.noteToEdit!.couleur;
    }
  }

  @override
  void dispose() {
    _titreController.dispose();
    _contenuController.dispose();
    super.dispose();
  }

  void _createNote() {
    if (formstate.currentState!.validate()) {
      final newNote = Note(
        id: widget.noteToEdit?.id ?? DateTime.now().toString(),
        titre: _titreController.text.trim(),
        contenu: _contenuController.text.trim(),
        couleur: selectedColor,
        dateCreation: widget.noteToEdit?.dateCreation ?? DateTime.now(),
        dateModification: widget.noteToEdit != null ? DateTime.now() : null,
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

              Row(
                children: [
                  buildColor('#FFE082'),
                  buildColor('#FFAB91'),
                  buildColor('#CF93D9'),
                  buildColor('#80DEEA'),
                  buildColor('#000000'),
                ],
              ),

              SizedBox(height: 20),

              MaterialButton(
                onPressed: () => _createNote(),
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

  Widget buildColor(String colorHex) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = colorHex;
        });
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Color(int.parse(colorHex.replaceFirst('#', '0xff'))),
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == colorHex
                ? Colors.black
                : Colors.transparent,
            width: 2,
          ),
        ),
      ),
    );
  }
}
