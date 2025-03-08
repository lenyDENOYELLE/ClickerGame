
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/enemy_viewmodel.dart';


class EnemyWidget extends StatelessWidget {
  const EnemyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    EnemyViewModel viewModel = context.watch<EnemyViewModel>();
    return FutureBuilder<bool>(
        future: viewModel.fetchEnemy(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                InkWell(
                  onTap: () => viewModel.attackEnemy(1),
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