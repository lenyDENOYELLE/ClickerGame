import 'package:flutter/material.dart';
import 'package:untitled1/core/services/player_service.dart';
import '../core/services/buy_service.dart';
import '../models/player_model.dart';

class PlayerViewModel with ChangeNotifier {
  final BuyService _buyService = BuyService();
  final PlayerService _playerService = PlayerService();
  Player? _player;

  Player? get player => _player;

  PlayerViewModel(){
    fetchPlayerById(1);
  }

  // Récupérer un joueur par son ID
  Future<void> fetchPlayerById(int idPlayer) async {
    // _player = await _playerService.getPlayerById(idPlayer);
    // notifyListeners(); // Notifier les écouteurs que l'état a changé


    try {
      _player = await PlayerService().getPlayerById(idPlayer);
      notifyListeners(); // Notifiez les écouteurs que le joueur a été chargé
    } catch (e) {
      print('Erreur lors du chargement du joueur: $e');
    }
  }

/*
  // Gagner de l'expérience
  Future<void> gainExperience(int experience) async {
    if (_player != null) {
      // Mettre à jour localement
      _player = _player!.copyWith(
        totalExperience: _player!.totalExperience + experience,
      );

      // Mettre à jour dans la base de données
      await _playerService.updatePlayer(_player!);

      // Notifier les écouteurs
      notifyListeners();
    }
  }*/

  // Gagner de l'expérience
  Future<void> gainExperience() async {
    if (_player != null) {
      // Mettre à jour localement
      _player = _player!.copyWith(
        totalExperience: _player!.totalExperience + player!.gainXp,
      );

      // Mettre à jour dans la base de données
      await _playerService.updatePlayer(_player!);

      // Notifier les écouteurs
      notifyListeners();
    }
  }





  // Insérer un nouveau joueur
  Future<void> insertPlayer(String pseudo, int totalExperience, int idEnnemy) async {
    final newPlayer = Player(
      idPlayer: 0, // L'ID sera généré par la base de données
      pseudo: pseudo,
      totalExperience: totalExperience,
      idEnnemy: idEnnemy,
      damage: 1,
      gainXp: 1,
    );

    await _playerService.insertPlayer(newPlayer);
    notifyListeners(); // Notifier les écouteurs que l'état a changé
  }

  // Mettre à jour un joueur existant
  Future<void> updatePlayer(Player player) async {
    await _playerService.updatePlayer(player);
    notifyListeners(); // Notifier les écouteurs que l'état a changé
  }

  // Supprimer un joueur par son ID
  Future<void> deletePlayer(int idPlayer) async {
    await _playerService.deletePlayer(idPlayer);
    _player = null; // Réinitialiser le joueur actuel
    notifyListeners(); // Notifier les écouteurs que l'état a changé
  }






  Future<void> buyNextEnhancement() async {
    if (_player != null) {
      try {
        // Acheter la prochaine amélioration via BuyService
        final updatedPlayer = await _buyService.buyEnhancement(_player!.idPlayer);

        // Mettre à jour le joueur localement
        _player = updatedPlayer;
        notifyListeners();
      } catch (e) {
        print('Erreur lors de l\'achat de l\'amélioration: $e');
        rethrow;
      }
    }
  }


/*
  Future<void> buyNextXpEnhancement() async {
    if (_player != null) {
      try {
        // Acheter la prochaine amélioration de gain d'expérience via BuyService
        final updatedPlayer = await _buyService.buyXpEnhancement(_player!.idPlayer);

        // Mettre à jour le joueur localement
        _player = updatedPlayer;
        notifyListeners();
      } catch (e) {
        print('Erreur lors de l\'achat de l\'amélioration de gain d\'expérience: $e');
        rethrow;
      }
    }
  }
*/


  Future<void> buyNextXpEnhancement() async {
    try {
      // Acheter la prochaine amélioration de gain d'expérience via BuyService
      final updatedPlayer = await _buyService.buyXpEnhancement(_player!.idPlayer);

      // Mettre à jour le joueur localement
      _player = updatedPlayer;
      notifyListeners();
/*
        // Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Amélioration de gain d\'XP achetée ! Gain XP: ${_player!.gainXp}')),
        );*/
    } catch (e) {/*
        // Afficher un message d'erreur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur: $e')),
        );*/
    }
  }
}