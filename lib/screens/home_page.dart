import 'package:bloc_notes/models/note.dart';
import 'package:bloc_notes/screens/create_page.dart';
import 'package:bloc_notes/widgets/note_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  List<Note> notes = [];

  @override
  void initState() {
    super.initState();
    notes = [
      Note(
        id: '1',
        titre: 'Shopping List 🛒',
        contenu: 'Buy milk, eggs, bread, and some fruits.',
        dateCreation: DateTime.now(),
      ),
      Note(
        id: '2',
        titre: 'Flutter Study 💻',
        contenu: 'Practice Bloc state management and Git commits.',
        dateCreation: DateTime.now(),
      ),
      Note(
        id: '3',
        titre: 'Gym Session 💪',
        contenu: 'Leg day at 6:00 PM. Don\'t forget the water bottle!',
        dateCreation: DateTime.now(),
      ),
      Note(
        id: '4',
        titre: 'Meeting Notes 📝',
        contenu: 'Discuss the new project requirements with the team.',
        dateCreation: DateTime.now(),
      ),
    ];
  }

  void _deleteNote(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Note"),
        content: const Text("Are you sure you want to delete this note?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                notes.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(10),

        child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            return NoteCard(
              note: notes[index],
              onLongPress: () => _deleteNote(index),
              onEdit: () async {
                final updatedNote = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreatePage(noteToEdit: notes[index]),
                  ),
                );

                if (updatedNote != null) {
                  setState(() {
                    notes[index] = updatedNote;
                  });
                }
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 10);
          },
          itemCount: notes.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          final note = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreatePage()),
          );

          if (note != null) {
            setState(() {
              notes.add(note);
            });
          }
        },
      ),
    );
  }
}
