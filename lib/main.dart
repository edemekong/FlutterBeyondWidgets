import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/ui/screens/home.dart';

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
