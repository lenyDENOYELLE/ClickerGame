
import 'package:flutter/material.dart';
import 'package:untitled1/core/services/enemy_service.dart';
import 'package:untitled1/exceptions/levelnotfound_exception.dart';
import 'package:untitled1/models/enemy.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';

class EnemyViewModel extends ChangeNotifier {
  final EnemyService _enemyRequest = EnemyService();
  late EnemyModel _enemy;
  bool fetchNewEnemy = true;
  int _level = 1;
  EnemyViewModel(){
    fetchEnemy();
  }

  int get level => _enemy.level;
  int get totalLife => _enemy.totalLife;
  int get currentLife => _enemy.currentLife;


  /*
  void nextEnemy(){
    _level++;
    fetchEnemy();
  }

  */

/*
  Future<bool> fetchEnemy() async{

      EnemyModel? enemytrouve = await _enemyRequest.getEnemyById(_level);


      if (enemytrouve != null){
        _enemy = enemytrouve;
        return true;
      }
      else{
        fetchNewEnemy = false;
        throw LevelNotFoundException(_level);
      }
  }*/


  Future<void> nextEnemy() async {
    _level++; // Passer au niveau suivant
    if (_level < 6) { // maxLevel est le nombre maximum de monstres
      await fetchEnemy(); // Charger le nouveau monstre
      notifyListeners(); // Notifier les écouteurs
    } else {
      print('Tous les monstres ont été vaincus !');
    }
  }


  Future<bool> fetchEnemy() async {
    EnemyModel? enemytrouve = await _enemyRequest.getEnemyById(_level);

    if (enemytrouve != null) {
      _enemy = enemytrouve;
      notifyListeners(); // Notifier les écouteurs que l'ennemi a été chargé
      return true;
    } else {
      fetchNewEnemy = false;
      throw LevelNotFoundException(_level);
    }
  }





  /*
  void attackEnemy(int damage){
    _enemy.reduceLife(damage);
    if (_enemy.currentLife <= 0){
      nextEnemy();
    }
    notifyListeners();
  }
  */

/*
  void attackEnemy(int damage) async {

      _enemy.reduceLife(damage);

      // Mettre à jour les points de vie dans la base de données
      await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

      // Vérifier si le monstre est mort
      if (_enemy.currentLife <= 0) {
        print('Enemy defeated!');
        _enemy.currentLife = _enemy.totalLife;
        await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

        nextEnemy(); // Passer au prochain ennemi
      }

      // Notifier les écouteurs que l'état a changé
      notifyListeners();
    }
    */

  /*
  void attackEnemy(int damage) async {
    if (_enemy.currentLife > 0) {
      // Réduire les points de vie localement
      _enemy.reduceLife(damage);

      // Vérifier si le monstre est mort avant de mettre à jour la base de données
      if (_enemy.currentLife <= 0) {
        print('Enemy defeated!');
        _enemy.currentLife = 0; // Assurer que currentLife ne devient pas négatif

        // Mettre à jour les points de vie dans la base de données
        await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

        // Réinitialiser les points de vie et passer au prochain ennemi
        _enemy.currentLife = _enemy.totalLife;
        await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

        await nextEnemy(); // Passer au prochain ennemi
      } else {
        // Mettre à jour les points de vie dans la base de données si le monstre n'est pas mort
        await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);
      }

      // Notifier les écouteurs que l'état a changé
      notifyListeners();
    }
  }
  */


/*
  Future<void> attackEnemy(int damage, PlayerViewModel playerViewModel) async {
    if (_enemy.currentLife > 0) {
      // Réduire les points de vie de l'ennemi
      _enemy.reduceLife(damage);

      // Mettre à jour les points de vie dans la base de données
      await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

      // Donner de l'expérience au joueur
      playerViewModel.gainExperience(1); // 1 point d'expérience par attaque

      // Vérifier si l'ennemi est mort
      if (_enemy.currentLife <= 0) {
        print('Enemy defeated!');

        // Réinitialiser les points de vie de l'ennemi
        _enemy.currentLife = _enemy.totalLife;
        await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

        // Passer au prochain ennemi
        await nextEnemy();
      }

      // Notifier les écouteurs
      notifyListeners();
    }
  }
*/


/*
  void attackEnemy(int damage, PlayerViewModel playerViewModel) async {

    _enemy.reduceLife(damage);

    // Mettre à jour les points de vie dans la base de données
    await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

    playerViewModel.gainExperience(1);

    // Vérifier si le monstre est mort
    if (_enemy.currentLife <= 0) {
      print('Enemy defeated!');
      _enemy.currentLife = _enemy.totalLife;
      await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

      nextEnemy(); // Passer au prochain ennemi
    }

    // Notifier les écouteurs que l'état a changé
    notifyListeners();
  }
*/

/*
  void attackEnemy(int damage, PlayerViewModel playerViewModel) async {
    // Réduire les points de vie de l'ennemi
    _enemy.reduceLife(damage);

    // Empêcher les points de vie négatifs
    if (_enemy.currentLife < 0) {
      _enemy.currentLife = 0;
    }


    // Donner de l'expérience au joueur
    playerViewModel.gainExperience(1);

    // Vérifier si le monstre est mort
    if (_enemy.currentLife <= 0) {
      print('Enemy defeated!');

      // Réinitialiser les points de vie de l'ennemi actuel (optionnel, selon votre logique)
      _enemy.currentLife = _enemy.totalLife;
      await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

      // Passer au prochain ennemi avant de réinitialiser les points de vie
      await nextEnemy();

    }else{
      // Mettre à jour les points de vie dans la base de données
      await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);
    }

    // Notifier les écouteurs que l'état a changé
    notifyListeners();
  }
*/


  Future<void> attackEnemy(PlayerViewModel playerViewModel) async {
      // Utiliser les dégâts du joueur
      final playerDamage = playerViewModel.player?.damage ?? 1;

      // Réduire les points de vie de l'ennemi
      _enemy.reduceLife(playerDamage);


      // Donner de l'expérience au joueur
      playerViewModel.gainExperience(1); // 1 point d'expérience par attaque

      // Vérifier si l'ennemi est mort
      if (_enemy.currentLife <= 0) {
        print('Enemy defeated!');

        // Réinitialiser les points de vie de l'ennemi
        _enemy.currentLife = _enemy.totalLife;
        await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);

        // Passer au prochain ennemi
        await nextEnemy();
      }else{
        // Mettre à jour les points de vie dans la base de données
        await _enemyRequest.updateEnemyLife(_enemy.level, _enemy.currentLife);
      }

      // Notifier les écouteurs que l'état a changé
      notifyListeners();

  }

  Image getImageEnemy(){
    return Image.asset('assets/enemies/enemy_$_level.png');
  }


  Stack getBarreDeVie(){
    double sizebar = 500;
    double heightbar = 30;
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
      Container(height: heightbar, width: sizebar, color: Colors.grey,),
      Container(height: heightbar, width: (_enemy.currentLife*sizebar/_enemy.totalLife), color: Colors.red,)
    ],);
  }


}