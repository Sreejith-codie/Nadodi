import 'package:flutter/foundation.dart';
import '../models/hidden_spot_model.dart';
import '../services/dataset_service.dart';

class HiddenSpotsProvider extends ChangeNotifier {
  final DatasetService _datasetService = DatasetService();

  List<HiddenSpot> _allSpots = [];
  List<HiddenSpot> _filteredSpots = [];

  List<HiddenSpot> get allSpots => _allSpots;
  List<HiddenSpot> get filteredSpots => _filteredSpots;

  Future<void> loadHiddenSpots() async {
    await _datasetService.loadDatasets();
    _allSpots = _datasetService.hiddenSpots;
    _filteredSpots = List.from(_allSpots);
    notifyListeners();
  }

  void filterByDistrict(String district) {
    if (district.isEmpty) {
      _filteredSpots = List.from(_allSpots);
    } else {
      _filteredSpots =
          _allSpots.where((s) => s.district == district).toList();
    }
    notifyListeners();
  }

  void filterByDifficulty(String difficulty) {
    if (difficulty.isEmpty) {
      _filteredSpots = List.from(_allSpots);
    } else {
      _filteredSpots =
          _allSpots.where((s) => s.difficulty == difficulty).toList();
    }
    notifyListeners();
  }

  void filterByType(String type) {
    if (type.isEmpty) {
      _filteredSpots = List.from(_allSpots);
    } else {
      _filteredSpots = _allSpots.where((s) => s.type == type).toList();
    }
    notifyListeners();
  }
}