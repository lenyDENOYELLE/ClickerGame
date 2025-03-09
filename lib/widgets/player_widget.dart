import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';

class PlayerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final playerViewModel = Provider.of<PlayerViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Player Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (playerViewModel.player != null)
              Text('Player: ${playerViewModel.player!.pseudo}'),
            if (playerViewModel.player != null)
              Text('Expérience: ${playerViewModel.player!.totalExperience}'),
            if (playerViewModel.player == null)
              CircularProgressIndicator(), // Affichez un indicateur de chargement si le joueur n'est pas encore chargé
          ],
        ),
      ),
    );
  }
}