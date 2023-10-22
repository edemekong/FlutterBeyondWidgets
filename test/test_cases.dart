import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:openweather_app/data/states/home_weather_provider.dart';
import 'package:openweather_app/ui/home_page.dart';

import 'utils/test_providers.dart';

class HomePageTestCases {
  static Future<void> launchHomePage(WidgetTester tester, {required ProviderContainer container}) async {
    await tester.pumpWidget(createWidgetUnderTest(
      testPageWidget: const HomePage(),
      parent: container,
    ));
    
    expect(find.byType(Scaffold), findsOneWidget);
    expect(container.read(homeWeatherProvider), [],reason: "initial weather list");
  }
}
