import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:openweather_app/ui/components/location_search_bar.dart';
import 'package:openweather_app/ui/components/weather_card.dart';
import 'package:openweather_app/ui/home_page.dart';

import 'mocks/location_data.dart';
import 'mocks/weather_api_repository.dart';
import 'utils/test_provider.dart';

class HomePageTestCases {
  static Future<void> launchWeatherHomePage(WidgetTester tester, {required ProviderContainer container}) async {
    await tester.pumpWidget(createWidgetUnderTest(
      testPageWidget: const HomePage(),
      parent: container,
    ));

    expect(find.byType(Scaffold), findsOneWidget);
  }

  static Future<void> searchBarIsVisible(WidgetTester tester, {required ProviderContainer container}) async {
    expect(find.byKey(const Key("page_title")), findsOneWidget);
    expect(find.byType(SearchLocationBar), findsOneWidget);
  }

  static Future<void> startLocationSearch(WidgetTester tester, {required ProviderContainer container}) async {
    final mockAPIRepository = container.read(mockWeatherAPIRepositoryProvider);

    await tester.enterText(find.byKey(const Key("search_textfield")), locations.first["name"]);
    await tester.pumpAndSettle(const Duration(milliseconds: 800));
    verify(() => mockAPIRepository.fetchLocations(locations.first["name"])).called(1);

  }

  static Future<void> fetchWeatherFromLocation(WidgetTester tester, {required ProviderContainer container}) async {
    final mockAPIRepository = container.read(mockWeatherAPIRepositoryProvider);

    await tester.tap(find.byKey(const Key("go_search")));
    await tester.pumpAndSettle();

    verify(() => mockAPIRepository.fetchLocations(locations.first["name"])).called(1);

    expect(find.byType(WeatherCard), findsOneWidget);
    expect(find.text(locations.first["name"]), findsOneWidget);
  }
}
