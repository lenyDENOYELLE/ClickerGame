
import 'package:flutter/material.dart';
import 'package:untitled1/core/services/enemy_service.dart';
import 'package:untitled1/exceptions/levelnotfound_exception.dart';
import 'package:untitled1/models/enemy.dart';

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

  void nextEnemy(){
    _level++;
    fetchEnemy();
  }

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
  }

  void attackEnemy(int damage){
    _enemy.reduceLife(damage);
    if (_enemy.currentLife <= 0){
      nextEnemy();
    }
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
      Container(height: heightbar, width: (_enemy.totalLife*100/sizebar), color: Colors.grey,),
      Container(height: heightbar, width: (_enemy.currentLife*100/sizebar), color: Colors.red,)
    ],);
  }


}