class Enhancement {
  final int id_enhancement;
  final int experience_cost;
  final int boost_value;
  final int id_type;

  Enhancement({
    required this.id_enhancement,
    required this.experience_cost,
    required this.boost_value,
    required this.id_type,
  });

  factory Enhancement.fromJson(Map<String, dynamic> json) {
    return Enhancement(
      id_enhancement: json['id_enhancement'],
      experience_cost: json['experience_cost'],
      boost_value: json['boost_value'],
      id_type: json['id_type'],
    );
  }
}