class Cours {
  final String titre;
  final String description;
  final String image;
  final String matiere;

  Cours({
    required this.titre,
    required this.description,
    required this.image,
    required this.matiere,
  });

  factory Cours.fromFirestore(doc) {
    final d = doc.data();
    return Cours(
      titre: d["titre"],
      description: d["description"],
      image: d["image"],
      matiere: d["matiere"],
    );
  }
}
