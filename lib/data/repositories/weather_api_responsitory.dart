// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:openweather_app/data/models/city.dart';
import 'package:openweather_app/data/models/weather.dart';
import 'package:openweather_app/main.dart';

final weatherApiRepositoryProvider = Provider<WeatherAPIRepository>((ref) {
  return WeatherAPIRepository();
});

const String BASE_URL = "http://api.openweathermap.org";

class WeatherAPIRepository {
  Future<Weather?> fetchWeatherFromAPI({required double lat, required double lon}) async {
    try {
      final url = Uri.parse('$BASE_URL/data/2.5/weather?lat=$lat&lon=$lon&appid=$WEATHER_API_KEY');

      Response response = await get(url);
      if (response.statusCode == 200) {
        final body = Map<String, dynamic>.from(jsonDecode(response.body));
        final data = List<dynamic>.from(body["weather"]);

        if (data.isNotEmpty) {
          final newWeather = Weather.fromMap(data.first);
          return newWeather.copyWith(
            dt: body["dt"],
            temp: body["main"]?["temp"],
          );
        }
      }
    } catch (_) {}
    return null;
  }

  Future<List<Location>> fetchLocations(String query) async {
    if (query.length < 2) return [];

    try {
      final url = Uri.parse('$BASE_URL/geo/1.0/direct?q=$query&limit=5&appid=$WEATHER_API_KEY');

      Response response = await get(url);
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final data = List<dynamic>.from(body);

        return data.map((e) => Location.fromMap(e)).toList();
      }
    } catch (_) {}
    return [];
  }
}
