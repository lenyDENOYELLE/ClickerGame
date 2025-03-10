import 'package:flutter/material.dart';
import 'package:untitled1/core/services/player_service.dart';
import '../core/services/user_service.dart';
import '../models/player_model.dart';
class PlayerListViewModel extends ChangeNotifier {
  final PlayerService _userRequest = PlayerService();
  List<Player> _users = [];
  bool _isLoading = false;
  String _error = '';

  List<Player> get users => _users;

  // La variable isLoading nous permet de mettre un état de chargement de nos données en attendant qu'elles s'affichent.
  bool get isLoading => _isLoading;
  String get errorMessage => _error;

  List<Player> _filteredUsers = [];
  List<Player> get filteredUsers => _filteredUsers;

  /*---------------------*/
  /* Lectures de données */
  /*---------------------*/
  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      List<Player>? players = await _userRequest.getPlayers();
      if (players != null){
        _users = players;
      }
      _filteredUsers = List.from(_users);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUserById(int id) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _users = await _userRequest.getPlayerById(id) as List<Player>;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
/*
  Future<void> fetchUsersByLastname(String pseudo) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _users = await _userRequest.getPlayer; //YA PAS DE CHERCHE BY PSEUDO
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
 */

  void filterUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      _filteredUsers = _users
          .where((user) =>
          user.toString().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  /*---------------------*/
  /* Ecriture de données */
  /*---------------------*/

  /* Méthode qui permet d'insérer des données en base */
  Future<void> addUser(String pseudo) async {
    try {
      await _userRequest.insertPlayer(pseudo);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /* Méthode qui permet de modifier des données en base */
  Future<void> updateUser(int id, {String? pseudo, String? total_experience, String? id_enemy}) async {
    try {
      await _userRequest.updatePlayer(id, pseudo: pseudo, total_experience: total_experience, id_enemy: id_enemy);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /* Méthode qui permet de supprimer des données en base */
  Future<void> deleteUser(int id) async {
    try {
      await _userRequest..deletePlayer(id);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}