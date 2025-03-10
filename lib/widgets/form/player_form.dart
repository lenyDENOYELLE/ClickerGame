import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/player_model.dart';
import '../../viewmodels/player_liste_viewmodel.dart';

class PlayerForm extends StatefulWidget {
  final PlayerListViewModel viewModel;
  final Player? user;

  const PlayerForm({super.key, required this.viewModel, this.user});

  @override
  PlayerFormState createState() => PlayerFormState();
}

class PlayerFormState extends State<PlayerForm> {
  late TextEditingController pseudoController;
  late TextEditingController expController;
  late TextEditingController levelController;

  @override
  void initState() {
    super.initState();
    pseudoController = TextEditingController(text: widget.user?.pseudo ?? '');
    expController = TextEditingController(text: widget.user?.totalExperience.toString() ?? '');
    levelController = TextEditingController(text: widget.user?.idEnemy.toString() ?? '');
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.user == null ? "Ajouter un utilisateur" : "Modifier l'utilisateur"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children:  widget.user == null ?
          [
            TextField(controller: pseudoController, decoration: const InputDecoration(labelText: "pseudo")),
            const SizedBox(height: 8),
          ] :
          [
            TextField(controller: pseudoController, decoration: const InputDecoration(labelText: "pseudo")),
            const SizedBox(height: 8),
            TextField(controller: expController,decoration: const InputDecoration(labelText: "total_experience"),),
            const SizedBox(height: 8),
            TextField(controller: levelController, decoration: const InputDecoration(labelText: "id_enemy"),),
            const SizedBox(height: 8),
          ]
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Annuler"),
        ),
        ElevatedButton(
          onPressed: () {
            if (pseudoController.text.isNotEmpty ) {
              if (widget.user == null) {
                widget.viewModel.addUser(
                  pseudoController.text,
                );
              } else {
                widget.viewModel.updateUser(
                  widget.user!.idPlayer,
                  pseudo: pseudoController.text,
                  total_experience: expController.text,
                  id_enemy: levelController.text,
                );
              }
              Navigator.pop(context);
            }
          },
          child: Text(widget.user == null ? "Ajouter" : "Modifier"),
        ),
      ],
    );
  }
}