class Usager {
  final int id;
  final String nomusager;
  final String motdepasse;
  static const String NOMTABLE = 'usagers';

  // Constructeur
  Usager({this.id, this.nomusager, this.motdepasse});

  // Convertit un utilisateur en Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomusager': nomusager,
      'motdepasse': motdepasse,
    };
  }

  @override
  String toString() {
    return 'Usager{id: $id, nomusager: $nomusager, motdepasse: $motdepasse}';
  }
}