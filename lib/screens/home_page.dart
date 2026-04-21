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
        titre: 'Shopping',
        contenu: 'Buy milk and eggs',
        dateCreation: DateTime.now(),
      ),
    ];
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
            return NoteCard(note: notes[index]);
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
