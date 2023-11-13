import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/data/models/city.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';
import 'package:openweather_app/data/states/home_weather_provider.dart';

final searchBarStateProvider = NotifierProvider<SearchBarState, List<Location>>(SearchBarState.new);

class SearchBarState extends Notifier<List<Location>> {
  Timer? timer;

  WeatherAPIRepository get weatherAPIrepo => ref.read(weatherApiRepositoryProvider);

  @override
  List<Location> build() {
    ref.onDispose(() {
      timer?.cancel();
      timer = null;
    });

    return [];
  }

  void onSearchLocation(String query) async {
    timer?.cancel();
    timer = null;

    timer = Timer(const Duration(milliseconds: 600), () async {
      List<Location> newLocations = await weatherAPIrepo.fetchLocations(query);
      state = [...newLocations];
    });
  }

  void onQuickSearch(String query) async {
    List<Location> newLocations = await weatherAPIrepo.fetchLocations(query);

    
    if (newLocations.isNotEmpty) {
      final location = newLocations.first;
      final weather = await weatherAPIrepo.fetchWeatherFromAPI(lat: location.lat, lon: location.lon);

      if (weather != null) {
        final weathers = ref.watch(homeWeatherProvider);
        ref.read(homeWeatherProvider.notifier).state = [
          weather.copyWith(location: location),
          ...weathers,
        ];
      }
    }
  }
}
