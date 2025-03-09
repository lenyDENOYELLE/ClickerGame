import 'package:untitled1/core/services/player_service.dart';
import 'package:untitled1/models/player_model.dart';
import 'package:flutter/material.dart';

class PlayerViewModel {
  final PlayerService _userRequest = PlayerService();
  PlayerModel? _joueur;


  void initJoueur(PlayerModel j) {
    _joueur = j;
  }

  bool joueurActif(){
    return _joueur != null;
  }

  int? level(){
    return _joueur?.id_enemy;
  }

  String? getPseudo(){
    return _joueur?.pseudo;
  }
}