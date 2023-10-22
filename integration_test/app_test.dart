import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';

import '../test/test_cases.dart';
import '../test/mocks/weather_api_repository.dart';
import '../test/utils/test_providers.dart';

void main() {
  group("e2e App test:", () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    final List<Override> overrides = [
      weatherApiRepositoryProvider.overrideWith(mockWeatherApi),
    ];

    testWidgets("search for weather", (tester) async {
      final container = createContainer(overrides: overrides);
      await HomePageTestCases.launchHomePage(tester, container: container);
    });
  });
}
