import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/player_model.dart';
import '../config/config.dart';

class PlayerService {


  Future<List<Player>?> getPlayers() async {
    final url = Uri.parse('${Config.baseUrl}/get_player.php');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        print(data);
        return data.map((user) => Player.fromJson(user)).toList(); // Retourner la liste de joueurs
      } else {
        print('Failed to load player: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching player: $e');
      return null;
    }
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
  Future<void> insertPlayer(pseudo) async {
    final url = Uri.parse('${Config.baseUrl}/post_player.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'insert',
          'pseudo': pseudo,
          'total_experience': 0,
          'id_enemy': 1,
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

  Future<void> updatePlayer(int id,
      {String? pseudo, String? total_experience, String? id_enemy, }) async {
    final url = Uri.parse('${Config.baseUrl}/post_player.php');
    Map<String, dynamic> data = {
      'action': 'update',
      'id_player': id,
    };

    if (pseudo != null) data["pseudo"] = pseudo;
    if (total_experience != null) data["total_experience"] = total_experience;
    if (id_enemy != null) data["id_enemy"] = id_enemy;

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
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