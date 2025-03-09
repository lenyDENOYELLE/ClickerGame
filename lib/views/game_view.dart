/*
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
*/

/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/enemy_viewmodel.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart'; // Importez le PlayerViewModel
import 'package:untitled1/widgets/enemy_widget.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickerGame'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: EnemyViewModel()), // EnemyViewModel
            ChangeNotifierProvider.value(value: PlayerViewModel()), // PlayerViewModel
          ],
          child: EnemyWidget(), // Votre widget EnemyWidget
        ),
      ),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';
import 'package:untitled1/widgets/enemy_widget.dart';



/*
class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickerGame'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => EnemyViewModel()..fetchEnemy()),
          ChangeNotifierProvider(create: (context) => PlayerViewModel()..fetchPlayerById(1)), // Remplacer 1 par l'ID du joueur
        ],
        child: Stack(
          children: [
            // Afficher le pseudo et l'expérience du joueur en haut à gauche
            Positioned(
              top: 16,
              left: 16,
              child: Consumer<PlayerViewModel>(
                builder: (context, playerViewModel, child) {
                  if (playerViewModel.player != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pseudo: ${playerViewModel.player!.pseudo}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Expérience: ${playerViewModel.player!.totalExperience}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    );
                  } else {
                    return const Text('Chargement du joueur...');
                  }
                },
              ),
            ),

            // Afficher l'ennemi au centre
            const Center(
              child: EnemyWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

*/

/*
class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickerGame'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(
        children: [
          // Afficher le pseudo et l'expérience du joueur en haut à gauche
          Positioned(
            top: 16,
            left: 16,
            child: Consumer<PlayerViewModel>(
              builder: (context, playerViewModel, child) {
                if (playerViewModel.player != null) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pseudo: ${playerViewModel.player!.pseudo}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Expérience: ${playerViewModel.player!.totalExperience}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                } else {
                  return const Text('Chargement du joueur...');
                }
              },
            ),
          ),

          // Afficher l'ennemi au centre
          const Center(
            child: EnemyWidget(),
          ),
        ],
      ),
    );
  }
}

*/
/*
class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickerGame'),
        backgroundColor: Colors.lightBlue, // Rendre l'AppBar transparente
        elevation: 0, // Supprimer l'ombre de l'AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Chemin de l'image
            fit: BoxFit.cover, // Ajuster l'image pour couvrir tout l'espace
          ),
        ),
        child: Stack(
          children: [
            // Image de fond
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Overlay sombre
            Container(
              color: Colors.black.withOpacity(0.5), // Couleur de superposition
            ),
            // Contenu
            Positioned(
              top: 16,
              left: 16,
              child: Consumer<PlayerViewModel>(
                builder: (context, playerViewModel, child) {
                  if (playerViewModel.player != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pseudo: ${playerViewModel.player!.pseudo}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Expérience: ${playerViewModel.player!.totalExperience}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Text(
                      'Chargement du joueur...',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                },
              ),
            ),
            const Center(
              child: EnemyWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
*/

/* derniere version qui marche
class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickerGame'),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Afficher le pseudo, l'expérience et les dégâts du joueur en haut à gauche
            Positioned(
              top: 16,
              left: 16,
              child: Consumer<PlayerViewModel>(
                builder: (context, playerViewModel, child) {
                  if (playerViewModel.player != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pseudo: ${playerViewModel.player!.pseudo}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'Expérience: ${playerViewModel.player!.totalExperience}',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'Dégâts: ${playerViewModel.player!.damage}',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    return const Text('Chargement du joueur...', style: TextStyle(color: Colors.white));
                  }
                },
              ),
            ),

            // Afficher l'ennemi au centre
            const Center(
              child: EnemyWidget(),
            ),

            // Bouton pour acheter une amélioration de DPS
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () async {
                  final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);

                  try {
                    await playerViewModel.buyNextEnhancement();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Amélioration achetée ! Dégâts: ${playerViewModel.player!.damage}')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $e')),
                    );
                  }
                },
                child: Text('Acheter amélioration DPS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/


/* obsolete
class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickerGame'),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Afficher le pseudo, l'expérience et les dégâts du joueur en haut à gauche
            Positioned(
              top: 16,
              left: 16,
              child: Consumer<PlayerViewModel>(
                builder: (context, playerViewModel, child) {
                  if (playerViewModel.player != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pseudo: ${playerViewModel.player!.pseudo}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'Expérience: ${playerViewModel.player!.totalExperience}',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'Dégâts: ${playerViewModel.player!.damage}',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    return const Text('Chargement du joueur...', style: TextStyle(color: Colors.white));
                  }
                },
              ),
            ),

            // Centrer l'ennemi au milieu de l'écran
            Center(
              child: EnemyWidget(),
            ),

            // Bouton pour acheter une amélioration de DPS
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () async {
                  final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);

                  try {
                    await playerViewModel.buyNextEnhancement();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Amélioration achetée ! Dégâts: ${playerViewModel.player!.damage}')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $e')),
                    );
                  }
                },
                child: Text('Acheter amélioration DPS'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/



class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClickerGame'),
        backgroundColor: Colors.lightBlue,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Afficher le pseudo, l'expérience et les dégâts du joueur en haut à gauche
            Positioned(
              top: 16,
              left: 16,
              child: Consumer<PlayerViewModel>(
                builder: (context, playerViewModel, child) {
                  if (playerViewModel.player != null) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pseudo: ${playerViewModel.player!.pseudo}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          'Expérience: ${playerViewModel.player!.totalExperience}',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'Dégâts: ${playerViewModel.player!.damage}',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Text(
                          'Gain XP par clic: ${playerViewModel.player!.gainXp}',
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    );
                  } else {
                    return const Text('Chargement du joueur...', style: TextStyle(color: Colors.white));
                  }
                },
              ),
            ),

            // Afficher l'ennemi au centre
            const Center(
              child: EnemyWidget(),
            ),

            // Bouton pour acheter une amélioration de DPS
            Positioned(
              bottom: 16,
              right: 16,
              child: ElevatedButton(
                onPressed: () async {
                  final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);

                  try {
                    await playerViewModel.buyNextEnhancement();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Amélioration achetée ! Dégâts: ${playerViewModel.player!.damage}')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $e')),
                    );
                  }
                },
                child: Text('Acheter amélioration DPS'),
              ),
            ),

            // Bouton pour acheter une amélioration de gain d'expérience
            Positioned(
              bottom: 16,
              left: 16,
              child: ElevatedButton(
                onPressed: () async {
                  final playerViewModel = Provider.of<PlayerViewModel>(context, listen: false);

                  try {
                    await playerViewModel.buyNextXpEnhancement();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Amélioration de gain d\'expérience achetée ! Expérience: ${playerViewModel.player!.totalExperience}')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $e')),
                    );
                  }
                },
                child: Text('Acheter amélioration XP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}