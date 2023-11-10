import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/data/models/city.dart';
import 'package:openweather_app/data/models/weather.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';

final homeWeatherProvider = NotifierProvider<HomeWeatherState, List<Weather>>(HomeWeatherState.new);

class HomeWeatherState extends Notifier<List<Weather>> {
  WeatherAPIRepository get weatherApiRepo => ref.read(weatherApiRepositoryProvider);

  @override
  List<Weather> build() {
    return [];
  }

  void onSelectLocation(Location location) async {
    final weather = await weatherApiRepo.fetchWeatherFromAPI(
      lat: location.lat,
      lon: location.lon,
    );

    if (weather != null) {
      state = [weather.copyWith(location:location ), ...state];
    }
  }
}
