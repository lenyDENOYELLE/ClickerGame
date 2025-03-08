class EnemyModel {
  final String name;
  final int totalLife;
  final int level;
  int currentLife;

  EnemyModel({
    required this.name,
    required this.totalLife,
    required this.level,
    required this.currentLife,
  }){
    //currentLife = totalLife;
  }



//En gros, la factory ca prend un json et ca renvoie l'objet cree correctement
  factory EnemyModel.fromJson(Map<String, dynamic> json){
    return EnemyModel(
        name: json['name'],
        totalLife: json['total_life'],
        level: json['level'],
        currentLife: json['current_life']
    );
  }

  void reduceLife(int attaque){
    this.currentLife -= attaque;
    print("Nouvelle vie : $currentLife"); // Debug
  }
}