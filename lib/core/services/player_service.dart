import '../../models/player_model.dart';
import 'api_service.dart';

class PlayerService {
  final ApiService apiService = ApiService();

  /*---------------------*/
  /* Lectures de données */
  /*---------------------*/

  /*
  * Cette fonction permet de récupérer la liste complète des users
  */
  Future<List<PlayerModel>> getPlayers() async {
    List<dynamic> data = await apiService.getRequest("get_player.php");
    return data.map((user) => PlayerModel.fromJson(user)).toList();
  }

  /*
  * Cette fonction permet de récupérer un utilisateur par son id
  */
  Future<PlayerModel?> getPlayerById(int id_player) async {
    Map<String, String> queryParams = {"id_player": id_player.toString()};
    List<dynamic> data = await apiService.getRequest("get_player.php", queryParams: queryParams);
    if (data.isNotEmpty) {
      return PlayerModel.fromJson(data.first);
    }
    return null;
  }

  /*
  * Cette fonction permet de récupérer un utilisateur par son nom
  */
  Future<List<PlayerModel>> getPlayerByLastname(String pseudo) async {
    Map<String, String> queryParams = {"pseudo": Uri.encodeComponent(pseudo)};
    List<dynamic> data = await apiService.getRequest("get_player.php", queryParams: queryParams);
    return data.map((user) => PlayerModel.fromJson(user)).toList();
  }

  /*
   * Cette fonction est un exemple de récupération de données multi-filtre
   */
  Future<List<PlayerModel>> getPlayersByFilters({String? pseudo, int? id_player}) async {
    Map<String, String> queryParams = {};
    if (pseudo != null) queryParams['pseudo'] = Uri.encodeComponent(pseudo);
    if (id_player != null) queryParams['id_player'] = id_player.toString();

    List<dynamic> data = await apiService.getRequest("get_player.php", queryParams: queryParams);
    return data.map((userData) => PlayerModel.fromJson(userData)).toList();
  }

  /*---------------------*/
  /* Ecriture de données */
  /*---------------------*/

  // Cette méthode permet d'ajouter un nouvel utilisateur à la base
  Future<void> insertPlayer(String pseudo) async {
    await apiService.postRequest("post_player.php", {
      "action": "insert",
      "pseudo": pseudo,
      "total_experience": 0,
      "id_enemy": 1
    });
  }

  // Cette méthode permet de modifier un utilisateur par son id.
  Future<void> updateUser(int id, {String? pseudo, String? total_experience, String? id_enemy}) async {
    Map<String, dynamic> data = {
      "action": "update",
      "id_player": id.toString(),
    };
    if (pseudo != null) data["pseudo"] = pseudo;
    if (total_experience != null) data["total_experience"] = total_experience;
    if (id_enemy != null) data["id_enemy"] = id_enemy;

    await apiService.postRequest("post_player.php", data);
  }

  // Cette méthode permet de supprimer un utilisateur par son id.
  Future<void> deleteUser(int id) async {
    await apiService.postRequest("post_player.php", {
      "action": "delete",
      "id_player": id.toString(),
    });
  }
}