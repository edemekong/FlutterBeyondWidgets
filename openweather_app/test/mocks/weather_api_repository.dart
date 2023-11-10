import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:openweather_app/data/models/city.dart';
import 'package:openweather_app/data/models/weather.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';

import 'location_data.dart';
import 'weather_data.dart';

final mockWeatherAPIRepositoryProvider = Provider<MockWeatherAPIRepository>((ref) {
  return MockWeatherAPIRepository();
});

class MockWeatherAPIRepository extends Mock implements WeatherAPIRepository {}

MockWeatherAPIRepository mockWeatherApi(Ref ref) {
  final queryLocation = locations.map((e) => Location.fromMap(e)).first;

  final mockAPIRepository = ref.read(mockWeatherAPIRepositoryProvider);

  when(() => mockAPIRepository.fetchWeatherFromAPI(lat: queryLocation.lat, lon: queryLocation.lon)).thenAnswer(
    (invocation) async {
      final weatherData = List.from(weathers.first["weather"]);
      final weather = Weather.fromMap(weatherData.first);

      return weather.copyWith(
        location: queryLocation,
        dt: weathers.first["dt"],
        main: weathers.first["main"],
      );
    },
  );

  when(() => mockAPIRepository.fetchLocations(queryLocation.name)).thenAnswer(
    (invocation) async => locations.map((e) => Location.fromMap(e)).toList(),
  );

  return mockAPIRepository;
}
