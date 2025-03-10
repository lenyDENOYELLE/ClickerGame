import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/viewmodels/game_viewmodel.dart';
import 'package:untitled1/viewmodels/player_viewmodel.dart';

import '../models/player_model.dart';

class PlayersTable extends StatelessWidget {
  final List<Player> users;
  final Function(Player) onEdit;
  final Function(int) onDelete;

  const PlayersTable({
    super.key,
    required this.users,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final joueur = context.watch<GameViewModel>();
    return DataTable(
      columnSpacing: 20,
      columns: const [
        DataColumn(label: Text("pseudo")),
        DataColumn(label: Text("exp")),
        DataColumn(label: Text("id_enemy")),
        DataColumn(label: Text("Actions")),
      ],
      rows: users.map((user) {
        return DataRow(cells: [
          DataCell(
              Text(user.pseudo),
              onTap: () => {
                joueur.initJoueur(user.idPlayer)
              }
          ),
          DataCell(Text(user.totalExperience.toString())),
          DataCell(Text(user.idEnemy.toString())),
          DataCell(Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => onEdit(user),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => onDelete(user.idPlayer),
              ),
            ],
          )),
        ]);
      }).toList(),
    );
  }
}