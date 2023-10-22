import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/data/models/city.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';

final searchBarStateProvider = NotifierProvider<SearchBarState, List<Location>>(SearchBarState.new);

class SearchBarState extends Notifier<List<Location>> {
  Timer? timer;

  WeatherAPIRepository get weatherAPIrepo => ref.read(weatherApiRepositoryProvider);

  @override
  List<Location> build() {
    ref.onDispose(_onDispose);
    return [];
  }

  void onSearchLocation(String query) {
    timer?.cancel();
    timer = null;

    timer = Timer(const Duration(milliseconds: 800), () async {
      final locations = await weatherAPIrepo.fetchLocations(query);
      state = [...locations];
    });
  }


  void _onDispose() {
    timer?.cancel();
    timer = null;
  }
}
