import 'package:flutter/material.dart';
import 'package:untitled1/core/services/player_service.dart';
import '../core/services/user_service.dart';
import '../models/player_model.dart';
class PlayerListViewModel extends ChangeNotifier {
  final PlayerService _userRequest = PlayerService();
  List<PlayerModel> _users = [];
  bool _isLoading = false;
  String _error = '';

  List<PlayerModel> get users => _users;

  // La variable isLoading nous permet de mettre un état de chargement de nos données en attendant qu'elles s'affichent.
  bool get isLoading => _isLoading;
  String get errorMessage => _error;

  List<PlayerModel> _filteredUsers = [];
  List<PlayerModel> get filteredUsers => _filteredUsers;

  /*---------------------*/
  /* Lectures de données */
  /*---------------------*/
  Future<void> fetchUsers() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _users = await _userRequest.getPlayers();
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
      _users = await _userRequest.getPlayerById(id) as List<PlayerModel>;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchUsersByLastname(String pseudo) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _users = await _userRequest.getPlayerByLastname(pseudo);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterUsers(String query) {
    if (query.isEmpty) {
      _filteredUsers = List.from(_users);
    } else {
      _filteredUsers = _users
          .where((user) =>
      user.pseudo.toLowerCase().contains(query.toLowerCase()) ||
          user.id_player.toString().contains(query.toLowerCase()))
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
      await _userRequest.updateUser(id, pseudo: pseudo, total_experience: total_experience, id_enemy: id_enemy);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  /* Méthode qui permet de supprimer des données en base */
  Future<void> deleteUser(int id) async {
    try {
      await _userRequest.deleteUser(id);
      await fetchUsers();
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}