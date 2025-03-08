

//import 'package:untitled1/core/services/api_service.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:untitled1/models/enemy.dart';

import '../config/config.dart';
// Pour l'instant, j'utiliserai des listes contenant les
// objets nécessaires car je ne peux pas encore implémenter l'api
class EnemyService {
  //final ApiService apiService = ApiService();
  /*
  final List<EnemyModel> _sansApi = [
    EnemyModel(name: 'blue slime', level: 1, totalLife: 10),
    EnemyModel(name: 'bat', level: 2, totalLife: 20),
    EnemyModel(name: 'king slime', level: 3, totalLife: 30),
    EnemyModel(name: 'golem', level: 4, totalLife: 40),
    EnemyModel(name: 'dragon', level: 5, totalLife: 50),
  ];
*/
  /*
  Future<EnemyModel?> getEnemyById(int id) async {
    return _sansApi[id-1];
  }*/

  Future<EnemyModel?> getEnemyById(int level) async {
    final url = Uri.parse('${Config.baseUrl}/get_enemy.php?level=$level');

    try {
      final response = await http.get(url);

      // Affichez la réponse JSON dans les logs
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);

        // Si la réponse est null (aucun ennemi trouvé)
        if (data == null) {
          print('No enemy found with level: $level');
          return null;
        }

        // Convertir la réponse JSON en un objet EnemyModel
        return EnemyModel.fromJson(data);
      } else {
        print('Failed to load enemy: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching enemy: $e');
      return null;
    }
  }








  // Future<void> updateEnemyLife(int level, int currentLife) async {
  //   final url = Uri.parse('${Config.baseUrl}/post_enemy.php');
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({
  //         'action': 'update',
  //         'level': level,
  //         'current_life': currentLife,
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       print('Enemy life updated successfully');
  //     } else {
  //       print('Failed to update enemy life: ${response.statusCode}');
  //       print('Response body: ${response.body}');
  //     }
  //   } catch (e) {
  //     print('Error updating enemy life: $e');
  //   }
  // }



  Future<void> updateEnemyLife(int level, int currentLife) async {
    final url = Uri.parse('${Config.baseUrl}/post_enemy.php');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json', // S'assurer de recevoir du JSON
        },
        body: json.encode({
          'action': 'update',
          'level': level,
          'current_life': currentLife,
        }),
      );

      // Vérifier le statut et afficher la réponse JSON
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Enemy life updated successfully');
      } else {
        print('Failed to update enemy life: ${response.statusCode}');
        print('Response error: ${response.body}');
      }
    } catch (e) {
      print('Error updating enemy life: $e');
    }
  }

}