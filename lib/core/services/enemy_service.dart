

//import 'package:untitled1/core/services/api_service.dart';
import 'package:untitled1/models/enemy.dart';
// Pour l'instant, j'utiliserai des listes contenant les
// objets nécessaires car je ne peux pas encore implémenter l'api
class EnemyService {
  //final ApiService apiService = ApiService();
  final List<EnemyModel> _sansApi = [
    EnemyModel(name: 'blue slime', level: 1, totalLife: 10),
    EnemyModel(name: 'green slime', level: 2, totalLife: 20),
    EnemyModel(name: 'red slime', level: 3, totalLife: 30),
    EnemyModel(name: 'yellow slime', level: 4, totalLife: 40),
    EnemyModel(name: 'king slime', level: 5, totalLife: 50),
  ];

  Future<EnemyModel?> getEnemyById(int id) async {
    return _sansApi[id-1];
  }
  }