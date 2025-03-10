import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/player_model.dart';
import '../config/config.dart';

class PlayerService {
  final ApiService apiService = ApiService();

  /*
  * Cette fonction permet de récupérer la liste complète des users
  */
  Future<List<PlayerModel>> getPlayers() async {
    List<dynamic> data = await apiService.getRequest("get_player.php");
    return data.map((user) => PlayerModel.fromJson(user)).toList();
  }

  /*
  * Cette fonction permet de récupérer un utilisateur par son nom
  */
  Future<List<PlayerModel>> getPlayerByLastname(String pseudo) async {
    Map<String, String> queryParams = {"pseudo": Uri.encodeComponent(pseudo)};
    List<dynamic> data = await apiService.getRequest("get_player.php", queryParams: queryParams);
    return data.map((user) => PlayerModel.fromJson(user)).toList();
  }

  /*
   * Cette fonction est un exemple de récupération de données multi-filtre
   */
  Future<List<PlayerModel>> getPlayersByFilters({String? pseudo, int? id_player}) async {
    Map<String, String> queryParams = {};
    if (pseudo != null) queryParams['pseudo'] = Uri.encodeComponent(pseudo);
    if (id_player != null) queryParams['id_player'] = id_player.toString();

    List<dynamic> data = await apiService.getRequest("get_player.php", queryParams: queryParams);
    return data.map((userData) => PlayerModel.fromJson(userData)).toList();
  }

  // Récupérer un joueur par son ID
  Future<Player?> getPlayerById(int idPlayer) async {
    final url = Uri.parse('${Config.baseUrl}/get_player.php?id_player=$idPlayer');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);

        if (data != null && data.isNotEmpty) {
          return Player.fromJson(data[0]); // Retourner le premier joueur trouvé
        } else {
          print('No player found with id: $idPlayer');
          return null;
        }
      } else {
        print('Failed to load player: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching player: $e');
      return null;
    }
  }

  // Insérer un nouveau joueur
  Future<void> insertPlayer(Player player) async {
    final url = Uri.parse('${Config.baseUrl}/post_player.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'insert',
          'pseudo': player.pseudo,
          'total_experience': player.totalExperience,
          'id_ennemy': player.idEnnemy,
        }),
      );

      if (response.statusCode == 200) {
        print('Player inserted successfully');
      } else {
        print('Failed to insert player: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error inserting player: $e');
    }
  }

  Future<void> updatePlayer(Player player) async {
    final url = Uri.parse('${Config.baseUrl}/post_player.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'update',
          'id_player': player.idPlayer,
          'pseudo': player.pseudo,
          'total_experience': player.totalExperience, // Mettre à jour l'expérience
          'id_ennemy': player.idEnnemy,
        }),
      );

      if (response.statusCode == 200) {
        print('Player updated successfully');
      } else {
        print('Failed to update player: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error updating player: $e');
    }
  }

  // Supprimer un joueur par son ID
  Future<void> deletePlayer(int idPlayer) async {
    final url = Uri.parse('${Config.baseUrl}/post_player.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'delete',
          'id_player': idPlayer,
        }),
      );

      if (response.statusCode == 200) {
        print('Player deleted successfully');
      } else {
        print('Failed to delete player: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error deleting player: $e');
    }
  }
}