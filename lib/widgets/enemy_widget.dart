
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/enemy_viewmodel.dart';

import '../viewmodels/player_viewmodel.dart';


class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    EnemyViewModel viewModel = context.watch<EnemyViewModel>();
    PlayerViewModel playerViewModel = context.watch<PlayerViewModel>();
    return FutureBuilder<bool>(
        future: viewModel.fetchEnemy(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                InkWell(
                  onTap: () => viewModel.attackEnemy(playerViewModel),
                    child: viewModel.getImageEnemy()
                ),
                viewModel.getBarreDeVie()
              ],
            );
          } else if (snapshot.hasError) {
            // Erreur lors de l'exécution
            return Text("Erreur : ${snapshot.error}");
          } else { // Exécution en cours
            return const CircularProgressIndicator();
            //C’est un widget de chargement.
          }
        }
    );
  }

}


/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/enemy_viewmodel.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';

class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final enemyViewModel = context.watch<EnemyViewModel>();
    final playerViewModel = context.watch<PlayerViewModel>();

    // Afficher un indicateur de chargement pendant que l'ennemi est en cours de chargement
    if (enemyViewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(), // Indicateur de chargement
      );
    }

    // Afficher un message d'erreur si le chargement de l'ennemi a échoué
    if (enemyViewModel.errorMessage != null) {
      return Center(
        child: Text(
          'Erreur : ${enemyViewModel.errorMessage}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    // Afficher l'ennemi une fois qu'il est chargé
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image de l'ennemi
        InkWell(
          onTap: () => enemyViewModel.attackEnemy(1, playerViewModel), // Attaquer l'ennemi
          child: enemyViewModel.getImageEnemy(),
        ),

        // Barre de vie de l'ennemi
        enemyViewModel.getBarreDeVie(),
      ],
    );
  }
}*/

