import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:openweather_app/data/repositories/weather_api_responsitory.dart';
import 'test_cases.dart';
import 'mocks/weather_api_repository.dart';
import 'utils/test_provider.dart';

void main() {
  group("Weather home page:", () {
    final List<Override> overrides = [
      weatherApiRepositoryProvider.overrideWith(mockWeatherApi),
    ];

    testWidgets("weather home page is mounted", (tester) async {
      final container = createContainer(overrides: overrides);
      HomePageTestCases.launchWeatherHomePage(tester, container: container);
    });

    testWidgets("weather search location bar is visible", (tester) async {
      final container = createContainer(overrides: overrides);

      await HomePageTestCases.launchWeatherHomePage(tester, container: container);
      await HomePageTestCases.searchBarIsVisible(tester);
    });

    testWidgets("weather search location bar is visible", (tester) async {
      final container = createContainer(overrides: overrides);

      await HomePageTestCases.launchWeatherHomePage(tester, container: container);
      await HomePageTestCases.searchBarIsVisible(tester);
    });

    testWidgets("search for location: (Atlanta, Geogia)", (tester) async {
      await mockNetworkImagesFor(() async {
        final container = createContainer(overrides: overrides);

        await HomePageTestCases.launchWeatherHomePage(tester, container: container);
        await HomePageTestCases.searchBarIsVisible(tester);
        await HomePageTestCases.startLocationSearch(tester);
      });
    });

    testWidgets("search for location & fetch weather: (Atlanta, Geogia)", (tester) async {
      await mockNetworkImagesFor(() async {
        final container = createContainer(overrides: overrides);

        await HomePageTestCases.launchWeatherHomePage(tester, container: container);
        await HomePageTestCases.searchBarIsVisible(tester);
        await HomePageTestCases.startLocationSearch(tester);
        await HomePageTestCases.fetchWeatherFromLocation(tester);
      });
    });
  });
}
