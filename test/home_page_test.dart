import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';
import 'test_cases.dart';
import 'mocks/weather_api_repository.dart';
import 'utils/test_providers.dart';

void main() {
  group("Weather home page:", () {
    final List<Override> overrides = [
      weatherApiRepositoryProvider.overrideWith(mockWeatherApi),
    ];

    testWidgets("home page is mounted", (tester) async {
      final container = createContainer(overrides: overrides);
      HomePageTestCases.launchHomePage(tester, container: container);
    });
  });
}
