import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/weather.dart';
import '../services/weather_api_service.dart';

class WeatherProvider extends ChangeNotifier {
  final WeatherApiService _apiService;

  static const String _unitsKey = 'temperature_units';

  WeatherProvider({WeatherApiService? apiService})
      : _apiService = apiService ?? WeatherApiService() {
    _loadUnits();
  }

  Weather? _weather;
  Weather? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _units = 'metric'; // 'metric' = °C, 'imperial' = °F
  String get units => _units;

  Future<void> _loadUnits() async {
    final prefs = await SharedPreferences.getInstance();
    final String? savedUnits = prefs.getString(_unitsKey);

    if (savedUnits != null &&
        (savedUnits == 'metric' || savedUnits == 'imperial')) {
      _units = savedUnits; // دلوقتي compiler متأكد إنها مش null
      notifyListeners();
    }
  }

  Future<void> _saveUnits() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_unitsKey, _units);
  }

  void setUnits(String newUnits) {
    if (newUnits == _units) return;
    _units = newUnits;
    _saveUnits();
    notifyListeners();
  }

  Future<void> fetchWeatherForCity(String city) async {
    if (city.isEmpty) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final w = await _apiService.getWeatherByCity(city, units: _units);
      _weather = w;
    } catch (e) {
      _weather = null;
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
