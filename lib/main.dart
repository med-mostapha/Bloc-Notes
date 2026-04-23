import 'package:bloc_notes/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bloc_notes/providers/note_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => NoteProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: HomePage()));
  }
}
