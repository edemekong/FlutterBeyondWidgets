import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/data/services/navigation_service.dart';

class OpenWeatherApp extends ConsumerWidget {
  const OpenWeatherApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationService = ref.read(navigationServiceProvider);

    return MaterialApp.router(
      routerConfig: navigationService.router,
      builder: (context, widget) => Overlay(
        initialEntries: [
          OverlayEntry(
            builder: (context) => widget!,
          ),
        ],
      ),
    );
  }
}
