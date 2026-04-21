class Note {
  final String id;
  final String titre;
  final String contenu;
  final DateTime dateCreation;
  final DateTime? dateModification;

  Note({
    required this.id,
    required this.titre,
    required this.contenu,
    required this.dateCreation,
    this.dateModification,
  });
}
