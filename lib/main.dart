// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/ui/home_page.dart';

const WEATHER_API_KEY = String.fromEnvironment("weather_api_key");

void main() {
  runApp(
    const ProviderScope(
      child: OpenWeatherApp(),
    ),
  );
}

class OpenWeatherApp extends ConsumerWidget {
  const OpenWeatherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}
