import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/game_viewmodel.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';
import 'package:untitled1/views/game_view.dart';
import 'package:untitled1/views/players_view.dart';
import 'package:untitled1/viewmodels/player_liste_viewmodel.dart';
import 'core/config/config.dart';
import 'viewmodels/user_viewmodel.dart';
Future main() async {
  await Config.load();
  runApp(
      ChangeNotifierProvider(
          create: (context) => GameViewModel(),
          child: const MyApp()
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final joueur = context.watch<GameViewModel>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerListViewModel()),
      ],
      child: MaterialApp(
        title: 'Clicker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: joueur.player.joueurActif() ? GameView() : PlayerView(),
      ),
    );
  }
}