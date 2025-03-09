import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/player_model.dart';
import '../config/config.dart';

class BuyService {
  Future<Player> buyEnhancement(int idPlayer) async {
    final url = Uri.parse('${Config.baseUrl}/post_buy.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'buy_enhancement',
          'id_player': idPlayer,
        }),
      );

      print('Response status: ${response.statusCode}'); // Log du statut de la réponse
      print('Response body: ${response.body}'); // Log du corps de la réponse

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['player'] != null) {
          return Player.fromJson(data['player']); // Retourner le joueur mis à jour
        } else {
          throw Exception('Player data is null in the response');
        }
      } else {
        throw Exception('Failed to buy enhancement: ${response.body}');
      }
    } catch (e) {
      print('Error in buyEnhancement: $e'); // Log de l'erreur
      throw Exception('Error buying enhancement: $e');
    }
  }











/*
  Future<Player> buyXpEnhancement(int idPlayer) async {
    final url = Uri.parse('${Config.baseUrl}/post_buy.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'buy_xp_enhancement',
          'id_player': idPlayer,
        }),
      );

      print('Response status: ${response.statusCode}'); // Log du statut de la réponse
      print('Response body: ${response.body}'); // Log du corps de la réponse

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['player'] != null) {
          return Player.fromJson(data['player']); // Retourner le joueur mis à jour
        } else {
          throw Exception('Player data is null in the response');
        }
      } else {
        throw Exception('Failed to buy xp enhancement: ${response.body}');
      }
    } catch (e) {
      print('Error in buyXpEnhancement: $e'); // Log de l'erreur
      throw Exception('Error buying xp enhancement: $e');
    }
  }*/



  Future<Player> buyXpEnhancement(int idPlayer) async {
    final url = Uri.parse('${Config.baseUrl}/post_buy.php');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'action': 'buy_xp_enhancement',
          'id_player': idPlayer,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['player'] != null) {
          return Player.fromJson(data['player']); // Retourner le joueur mis à jour
        } else {
          throw Exception('Player data is null in the response');
        }
      } else {
        throw Exception('Failed to buy XP enhancement: ${response.body}');
      }
    } catch (e) {
      print('Error in buyXpEnhancement: $e');
      throw Exception('Error buying XP enhancement: $e');
    }
  }
}