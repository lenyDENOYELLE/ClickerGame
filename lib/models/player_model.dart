
class Player {
  final int idPlayer;
  final String pseudo;
  final int totalExperience;
  final int damage;
  final int idEnemy;
  final int gainXp; // Nouvel attribut pour le gain d'XP par clic

  Player({
    required this.idPlayer,
    required this.pseudo,
    required this.totalExperience,
    required this.damage,
    required this.idEnemy,
    required this.gainXp, // Ajout du nouvel attribut
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      idPlayer: json['id_player'],
      pseudo: json['pseudo'] ?? '',
      totalExperience: json['total_experience'] ?? 1,
      damage: json['damage'] ?? 1,
      idEnemy: json['id_enemy'] ?? 1,
      gainXp: json['gain_xp'] ?? 1, // Valeur par défaut si non présente
    );
  }

  Player copyWith({
    int? idPlayer,
    String? pseudo,
    int? totalExperience,
    int? damage,
    int? idEnemy,
    int? gainXp, // Ajout du nouvel attribut dans copyWith
  }) {
    return Player(
      idPlayer: idPlayer ?? this.idPlayer,
      pseudo: pseudo ?? this.pseudo,
      totalExperience: totalExperience ?? this.totalExperience,
      damage: damage ?? this.damage,
      idEnemy: idEnemy ?? this.idEnemy,
      gainXp: gainXp ?? this.gainXp, // Ajout du nouvel attribut
    );
  }
}

