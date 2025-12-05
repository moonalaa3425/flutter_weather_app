import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? weather;
  bool isLoading = false;
  String? errorMessage;
  String unit = 'metric';

  List<String> favorites = [];
  List<String> searchHistory = [];

  WeatherProvider() {
    _loadPrefs();
  }

  // Load favorites and unit from SharedPreferences
  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    favorites = prefs.getStringList('favorites') ?? [];
    unit = prefs.getString('unit') ?? 'metric';
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favorites);
  }

  // Change temperature unit
  Future<void> changeUnit(String newUnit) async {
    unit = newUnit;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('unit', unit);
    notifyListeners();
  }

  // Add city to favorites
  Future<void> addFavorite(String city) async {
    if (!favorites.contains(city)) {
      favorites.add(city);
      await _saveFavorites();
      notifyListeners();
    }
  }

  // Remove city from favorites
  Future<void> removeFavorite(String city) async {
    favorites.remove(city);
    await _saveFavorites();
    notifyListeners();
  }

  // Add to search history
  Future<void> addSearchHistory(String city) async {
    if (!searchHistory.contains(city)) {
      searchHistory.insert(0, city);
      if (searchHistory.length > 5) searchHistory.removeLast();
      notifyListeners();
    }
  }

  // Fetch weather by city
  Future<void> fetchWeatherByCity(String city) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      weather = await WeatherService.fetchWeatherByCity(
        city: city,
        unit: unit,
      );
      await addSearchHistory(city);
    } catch (e) {
      errorMessage = 'Failed to load weather data';
    }

    isLoading = false;
    notifyListeners();
  }

  // *GPS-related functions removed* for simplicity
}