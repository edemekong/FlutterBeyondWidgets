import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/data/models/weather.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';

final weatherStateProvider = StateNotifierProvider<WeatherState, Weather?>((ref) {
  return WeatherState(ref: ref);
});

class WeatherState extends StateNotifier<Weather?> {
  final Ref ref;

  WeatherState({required this.ref}) : super(null) {
    ref.read(weatherApiRepositoryProvider).fetchWeatherFromAPI(
          latitude: 0,
          longitude: 0,
        );

 
  }
}
