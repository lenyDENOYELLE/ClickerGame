import 'package:flutter/material.dart';
import 'package:untitled1/models/player_model.dart';
import 'package:untitled1/viewmodels/enemy_viewmodel.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';

class GameViewModel extends ChangeNotifier{
  PlayerViewModel player = PlayerViewModel();
  late EnemyViewModel enemyViewModel;


  void initEnemy(){
    enemyViewModel = EnemyViewModel(level: player.getLevel());
  }

  void initJoueur(int id){
    player.initJoueur(id);
    initEnemy();
    notifyListeners();
  }

  String? getPseudo(){
    return player.getPseudo();
  }

}