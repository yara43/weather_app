import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/weather.dart';

class WeatherApiService {
  final http.Client _client;

  WeatherApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<Weather> getWeatherByCity(
    String city, {
    String units = 'metric', // 'metric' = °C, 'imperial' = °F
  }) async {
    final uri = Uri.parse(
      '${ApiConfig.openWeatherBaseUrl}/weather?q=$city'
      '&appid=${ApiConfig.openWeatherApiKey}'
      '&units=$units',
    );

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return Weather.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception('Invalid API key (401)');
    } else if (response.statusCode == 404) {
      throw Exception('City not found (404)');
    } else {
      throw Exception(
        'Failed to load weather: '
        '${response.statusCode} ${response.reasonPhrase}',
      );
    }
  }
}
