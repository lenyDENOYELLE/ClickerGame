/*
class Player {

  final int idPlayer;
  final String pseudo;
  final int totalExperience;
  final int idEnnemy;

  Player({
    required this.idPlayer,
    required this.pseudo,
    required this.totalExperience,
    required this.idEnnemy,
  });

  // Factory pour créer un objet Player à partir d'un JSON
  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      idPlayer: json['id_player'],
      pseudo: json['pseudo'],
      totalExperience: json['total_experience'],
      idEnnemy: json['id_ennemy'],
    );
  }

  // Convertir l'objet Player en JSON
  Map<String, dynamic> toJson() {
    return {
      'id_player': idPlayer,
      'pseudo': pseudo,
      'total_experience': totalExperience,
      'id_ennemy': idEnnemy,
    };
  }



  // Méthode copyWith pour mettre à jour les propriétés
  Player copyWith({
    int? idPlayer,
    String? pseudo,
    int? totalExperience,
    int? idEnnemy,
  }) {
    return Player(
      idPlayer: idPlayer ?? this.idPlayer,
      pseudo: pseudo ?? this.pseudo,
      totalExperience: totalExperience ?? this.totalExperience,
      idEnnemy: idEnnemy ?? this.idEnnemy,
    );
  }
}
 */


class Player {
  final int idPlayer;
  final String pseudo;
  final int totalExperience;
  final int damage; // Ajoutez ce champ
  final int idEnnemy;

  Player({
    required this.idPlayer,
    required this.pseudo,
    required this.totalExperience,
    required this.damage, // Ajoutez ce champ
    required this.idEnnemy,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      idPlayer: json['id_player'],
      pseudo: json['pseudo'],
      totalExperience: json['total_experience'],
      damage: json['damage'], // Ajoutez ce champ
      idEnnemy: json['id_ennemy'],
    );
  }

  // Méthode copyWith pour mettre à jour les propriétés
  Player copyWith({
    int? idPlayer,
    String? pseudo,
    int? totalExperience,
    int? damage, // Ajoutez ce champ
    int? idEnnemy,
  }) {
    return Player(
      idPlayer: idPlayer ?? this.idPlayer,
      pseudo: pseudo ?? this.pseudo,
      totalExperience: totalExperience ?? this.totalExperience,
      damage: damage ?? this.damage, // Ajoutez ce champ
      idEnnemy: idEnnemy ?? this.idEnnemy,
    );
  }
}



