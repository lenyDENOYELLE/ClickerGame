
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/enemy_viewmodel.dart';
import 'package:untitled1/widgets/enemy_widget.dart';

class GameView extends StatelessWidget{
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickerGame'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ChangeNotifierProvider.value(value: EnemyViewModel(),
          child: EnemyWidget(),)
      ),
    );
  }
}