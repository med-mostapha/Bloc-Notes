import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String id;
  final String titre;
  final String contenu;
  final String couleur;
  final DateTime dateCreation;
  final DateTime? dateModification;

  Note({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.dateCreation,
    this.dateModification,
    required this.couleur,
  });

  factory Note.fromMap(String id, Map<String, dynamic> data) {
    return Note(
      id: id,
      titre: data['titre'] ?? '',
      contenu: data['contenu'] ?? '',
      couleur: data['couleur'] ?? '#FFFFFF',
      dateCreation: (data['dateCreation'] as Timestamp).toDate(),
      dateModification: data['dateModification'] != null
          ? (data['dateModification'] as Timestamp).toDate()
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'contenu': contenu,
      'couleur': couleur,
      'dateCreation': dateCreation,
      if (dateModification != null) 'dateModification': dateModification,
    };
  }
}
