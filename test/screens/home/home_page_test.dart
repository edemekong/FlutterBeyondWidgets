import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';

import '../../mocks/repositories/weather_api_repository.dart';
import '../../utils/test_provider.dart';
import 'cases.dart';

void main() {
  group("weather home page:", () {
    final List<Override> overrides = [
      weatherApiRepositoryProvider.overrideWith(mockWeatherApi),
    ];

    testWidgets("home page scaffold is mounted", (tester) async {
      final container = createContainer(
        overrides: overrides,
      );
      
      HomePageTestCases.launchHomePage(tester, container: container);
    });
  });
}
