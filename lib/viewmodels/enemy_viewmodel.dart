
import 'package:flutter/material.dart';
import 'package:untitled1/core/services/enemy_service.dart';
import 'package:untitled1/exceptions/levelnotfound_exception.dart';
import 'package:untitled1/models/enemy.dart';

class EnemyViewModel extends ChangeNotifier {
  final EnemyService _enemyRequest = EnemyService();
  late EnemyModel _enemy;
  bool fetchNewEnemy = true;
  int _level = 1;
  EnemyViewModel({int? level}){
    if (level != null){
      _level = level;
    }
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
    _level++;
    await fetchEnemy(); // Attendre que le prochain ennemi soit chargé
    notifyListeners(); // Notifier les écouteurs que l'ennemi a changé
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
    notifyListeners();
  }


}