import 'package:flutter/foundation.dart';
import '../models/place_model.dart';
import '../services/dataset_service.dart';

class PlacesProvider extends ChangeNotifier {
  final DatasetService _datasetService = DatasetService();

  List<TouristPlace> _allPlaces = [];
  List<TouristPlace> _filteredPlaces = [];
  List<TouristPlace> _savedPlaces = [];
  String _selectedCategory = '';
  String _selectedDistrict = '';
  String _searchQuery = '';

  List<TouristPlace> get allPlaces => _allPlaces;
  List<TouristPlace> get filteredPlaces => _filteredPlaces;
  List<TouristPlace> get savedPlaces => _savedPlaces;
  String get selectedCategory => _selectedCategory;
  String get selectedDistrict => _selectedDistrict;

  Future<void> loadPlaces() async {
    await _datasetService.loadDatasets();
    _allPlaces = _datasetService.places;
    _filteredPlaces = List.from(_allPlaces);
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    _applyFilters();
  }

  void filterByDistrict(String district) {
    _selectedDistrict = district;
    _applyFilters();
  }

  void searchPlaces(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void clearFilters() {
    _selectedCategory = '';
    _selectedDistrict = '';
    _searchQuery = '';
    _applyFilters();
  }

  void _applyFilters() {
    _filteredPlaces = _allPlaces.where((place) {
      bool matchesCategory =
          _selectedCategory.isEmpty || place.category == _selectedCategory;
      bool matchesDistrict =
          _selectedDistrict.isEmpty || place.district == _selectedDistrict;
      bool matchesSearch = _searchQuery.isEmpty ||
          place.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          place.district.toLowerCase().contains(_searchQuery.toLowerCase());

      return matchesCategory && matchesDistrict && matchesSearch;
    }).toList();

    notifyListeners();
  }

  void toggleSavePlace(TouristPlace place) {
    final index =
        _allPlaces.indexWhere((p) => p.id == place.id);
    if (index != -1) {
      _allPlaces[index] = _allPlaces[index].copyWith(
        isSaved: !_allPlaces[index].isSaved,
      );

      if (_allPlaces[index].isSaved) {
        _savedPlaces.add(_allPlaces[index]);
      } else {
        _savedPlaces.removeWhere((p) => p.id == place.id);
      }

      _applyFilters();
    }
  }

  bool isPlaceSaved(int placeId) {
    return _savedPlaces.any((p) => p.id == placeId);
  }

  List<String> getCategories() {
    return _datasetService.getDistinctCategories();
  }

  List<String> getDistricts() {
    return _datasetService.getDistinctDistricts();
  }
}