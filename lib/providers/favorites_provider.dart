import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  static const String _prefsKey = 'favorite_cities';

  List<String> _favorites = [];
  List<String> get favorites => List.unmodifiable(_favorites);

  FavoritesProvider() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList(_prefsKey) ?? [];
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_prefsKey, _favorites);
  }

  bool isFavorite(String city) {
    return _favorites.contains(city);
  }

  Future<void> addFavorite(String city) async {
    if (city.isEmpty || _favorites.contains(city)) return;
    _favorites.add(city);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> removeFavorite(String city) async {
    _favorites.remove(city);
    await _saveFavorites();
    notifyListeners();
  }
}
