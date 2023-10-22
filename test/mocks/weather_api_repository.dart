import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';

final mockWeatherAPIRepositoryProvider = Provider<MockWeatherAPIRepository>((ref) {
  return MockWeatherAPIRepository();
});

class MockWeatherAPIRepository extends Mock implements WeatherAPIRepository {}

MockWeatherAPIRepository mockWeatherApi(Ref ref) {
  final mockAPIRepository = ref.read(mockWeatherAPIRepositoryProvider);
  when(() => mockAPIRepository.fetchWeatherFromAPI(lat: 0,lon: 0)).thenAnswer(
    (invocation) async => null,
  );

  return mockAPIRepository;
}