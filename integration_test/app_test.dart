import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';

import '../test/test_cases.dart';
import '../test/mocks/weather_api_repository.dart';
import '../test/utils/test_provider.dart';

void main() {
  group("e2e App test:", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    final List<Override> overrides = [
      weatherApiRepositoryProvider.overrideWith(mockWeatherApi),
    ];

    testWidgets("search for weather", (tester) async {
      final container = createContainer(overrides: overrides);
      await HomePageTestCases.launchWeatherHomePage(tester, container: container);
      await HomePageTestCases.searchBarIsVisible(tester, container: container);
      await HomePageTestCases.startLocationSearch(tester, container: container);
      await HomePageTestCases.fetchWeatherFromLocation(tester, container: container);
    });
  });
}
