class PlayerModel{
  final int id_player;
  final String pseudo;
  final int total_experience;
  final int id_enemy;

  // Constructeur classique
  PlayerModel({
    required this.id_player,
    required this.pseudo,
    required this.total_experience,
    required this.id_enemy,
  });

  /*
   * Un factory en Flutter est un constructeur particulier qui permet
   * de créer des objets en effectuant des traitements et
   * des vérifications supplémentaires sur les paramètres
   * avant l'instanciation de notre objet.
   * Ici, on convertit les données Json de notre api en objet User
   */
  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      id_player: json['id_player'] ?? 0,
      pseudo: json['pseudo'] ?? '???',
      total_experience: json['total_experience'] ?? '0',
      id_enemy: json['id_enemy'] ?? '1',
    );
  }

}