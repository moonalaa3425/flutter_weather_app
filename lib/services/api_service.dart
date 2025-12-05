// lib/services/api_service.dart
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../utils/constants.dart';

class ApiService {
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<WeatherModel> fetchWeather(String city, String unit) async {
    final url = Uri.parse(
      "$baseUrl?q=${Uri.encodeComponent(city)}&units=$unit&appid=${AppConstants.OPENWEATHER_API_KEY}",
    );

    try {
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: 20)); // مهم

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return WeatherModel.fromJson(data);
      } else if (response.statusCode == 404) {
        throw Exception("City not found");
      } else if (response.statusCode == 401) {
        throw Exception("Invalid API Key");
      } else {
        throw Exception(
          "Failed to fetch weather (code: ${response.statusCode})",
        );
      }
    } on SocketException {
      throw Exception("No Internet Connection");
    } on TimeoutException {
      throw Exception("Request Timeout");
    } on FormatException {
      throw Exception("Invalid Response Format");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }
}
