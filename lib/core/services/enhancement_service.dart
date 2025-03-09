import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:untitled1/models/enhancement_model.dart';
import '../config/config.dart';

class EnhancementService {
  // Récupérer les améliorations
  Future<List<Enhancement>> getEnhancements() async {
    final url = Uri.parse('${Config.baseUrl}/get_enhancement.php');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Enhancement.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load enhancements: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching enhancements: $e');
    }
  }
}