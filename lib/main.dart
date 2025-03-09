/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/views/game_view.dart';
import 'core/config/config.dart';
import 'viewmodels/user_viewmodel.dart';
Future main() async {
  await Config.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
      ],
      child: MaterialApp(
        title: 'Clicker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GameView(),
      ),
    );
  }
}
 */

/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/views/game_view.dart';
import 'core/config/config.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/player_viewmodel.dart'; // Importez PlayerViewModel

Future main() async {
  await Config.load(); // Chargez la configuration
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerViewModel()), // PlayerViewModel
      ],
      child: MaterialApp(
        title: 'Clicker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GameView(), // Utilisez GameView comme écran principal
      ),
    );
  }
}

*/

/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/views/game_view.dart';
import 'core/config/config.dart';
import 'viewmodels/user_viewmodel.dart';
import 'viewmodels/player_viewmodel.dart'; // Importez PlayerViewModel
import 'viewmodels/enemy_viewmodel.dart'; // Importez EnemyViewModel

Future main() async {
  await Config.load(); // Chargez la configuration
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()), // UserViewModel
        ChangeNotifierProvider(create: (context) => PlayerViewModel()), // PlayerViewModel
        ChangeNotifierProvider(create: (context) => EnemyViewModel()), // EnemyViewModel
      ],
      child: MaterialApp(
        title: 'Clicker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
          useMaterial3: true,
        ),
        home: const GameView(), // Utilisez GameView comme écran principal
      ),
    );
  }
}
*/




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/views/game_view.dart';
import 'core/config/config.dart';
import 'viewmodels/player_viewmodel.dart';
import 'viewmodels/enemy_viewmodel.dart';
import 'viewmodels/enhancement_viewmodel.dart';

Future main() async {
  await Config.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlayerViewModel()),
        ChangeNotifierProvider(create: (context) => EnemyViewModel()),
        ChangeNotifierProvider(create: (context) => EnhancementViewModel()),
      ],
      child: MaterialApp(
        title: 'Clicker',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const GameView(),
      ),
    );
  }
}