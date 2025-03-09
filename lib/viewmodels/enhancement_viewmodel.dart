import 'package:flutter/material.dart';
import 'package:untitled1/core/services/enhancement_service.dart';
import '../models/enhancement_model.dart';

class EnhancementViewModel with ChangeNotifier {
  final EnhancementService _enhancementService = EnhancementService();
  List<Enhancement> _enhancements = [];

  List<Enhancement> get enhancements => _enhancements;

  EnhancementViewModel() {
    fetchEnhancements();
  }

  // Récupérer les améliorations
  Future<void> fetchEnhancements() async {
    try {
      _enhancements = await _enhancementService.getEnhancements();
      notifyListeners();
    } catch (e) {
      print('Erreur lors du chargement des améliorations: $e');
    }
  }

  // Récupérer la prochaine amélioration de DPS
  Enhancement? getNextDpsEnhancement() {
    return _enhancements.firstWhere(
          (enhancement) => enhancement.id_type == 1, // 1 = DPS
    );
  }


  // Récupérer la prochaine amélioration de gain d'expérience
  Enhancement? getNextXpEnhancement() {
    return _enhancements.firstWhere(
          (enhancement) => enhancement.id_type == 2, // 2 = XP
    );
  }
}