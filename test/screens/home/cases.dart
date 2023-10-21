import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:openweather_app/ui/screens/home.dart';

import '../../mocks/repositories/weather_api_repository.dart';
import '../../utils/test_provider.dart';

class HomePageTestCases {
  static Future<void> launchHomePage(WidgetTester tester, {required ProviderContainer container}) async {
    await tester.pumpWidget(createWidgetUnderTest(
      testPageWidget: const HomePage(),
      parent: container,
    ));
    
    expect(find.byType(Scaffold), findsOneWidget);
    verify(() => container.read(mockWeatherAPIRepositoryProvider).fetchWeatherFromAPI(latitude: 0, longitude: 0)).called(1);
  }
}
