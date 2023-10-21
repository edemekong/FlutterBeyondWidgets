// ignore_for_file: constant_identifier_names

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/data/models/weather.dart';

final weatherApiRepositoryProvider = Provider<WeatherAPIRepository>((ref) {
  return WeatherAPIRepository();
});

const String BASE_URL = "http://api.openweathermap.org";

class WeatherAPIRepository {

  Future<Weather?> fetchWeatherFromAPI({required double latitude, required double longitude}) async {
    try {
      
    } catch (_) {}
    return null;
  }
}
