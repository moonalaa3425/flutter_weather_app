import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  static const String apiKey = 'a6d64fb1d0f3fd5e64083c4cf19649d0';

  static Future<WeatherModel> fetchWeatherByCity({
    required String city,
    required String unit,
  }) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$city&units=$unit&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  static Future<WeatherModel> fetchWeatherByLocation({
    required double lat,
    required double lon,
    required String unit,
  }) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&units=$unit&appid=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }
}