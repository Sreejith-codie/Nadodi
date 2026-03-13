import 'package:flutter/foundation.dart';
import '../models/hotel_model.dart';
import '../services/dataset_service.dart';

class HotelsProvider extends ChangeNotifier {
  final DatasetService _datasetService = DatasetService();

  List<Hotel> _allHotels = [];
  List<Hotel> _filteredHotels = [];

  List<Hotel> get allHotels => _allHotels;
  List<Hotel> get filteredHotels => _filteredHotels;

  Future<void> loadHotels() async {
    await _datasetService.loadDatasets();
    _allHotels = _datasetService.hotels;
    _filteredHotels = List.from(_allHotels);
    notifyListeners();
  }

  void filterByDistrict(String district) {
    if (district.isEmpty) {
      _filteredHotels = List.from(_allHotels);
    } else {
      _filteredHotels =
          _allHotels.where((h) => h.district == district).toList();
    }
    notifyListeners();
  }

  void filterByType(String type) {
    if (type.isEmpty) {
      _filteredHotels = List.from(_allHotels);
    } else {
      _filteredHotels = _allHotels.where((h) => h.type == type).toList();
    }
    notifyListeners();
  }

  List<Hotel> getHotelsByDistrict(String district) {
    return _allHotels.where((h) => h.district == district).toList();
  }
}