
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/enemy_viewmodel.dart';
import 'package:untitled1/viewmodels/game_viewmodel.dart';
import 'package:untitled1/widgets/enemy_widget.dart';

class GameView extends StatelessWidget{
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    String? pseudo = context.watch<GameViewModel>().getPseudo();
    return Scaffold(
      appBar: AppBar(
        title: Text(pseudo == null ? "???" : pseudo), //Insérer le nom du joueur
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ChangeNotifierProvider.value(
          value: context.watch<GameViewModel>().enemyViewModel,
          child: EnemyWidget(),
        )
      ),
    );
  }
}