import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openweather_app/constants/route_paths.dart';
import 'package:openweather_app/ui/screens/history.dart';
import 'package:openweather_app/ui/screens/home/home_page.dart';
import 'package:openweather_app/ui/screens/tab_overlay.dart';
import 'package:openweather_app/ui/screens/weather_detail.dart';

final navigationServiceProvider = Provider<NavigationService>((ref) {
  return NavigationService();
});

class NavigationService {
  final GlobalKey<NavigatorState> mainNavigationKey = GlobalKey<NavigatorState>();

  GoRouter get router => GoRouter(
        navigatorKey: mainNavigationKey,
        initialLocation: AppRoutes.home.path,
        routes: [
          StatefulShellRoute.indexedStack(
            parentNavigatorKey: mainNavigationKey,
            builder: (context, state, navigationShell) => TabOverlay(
              navigationShell: navigationShell,
            ),
            branches: [
              StatefulShellBranch(
                initialLocation: AppRoutes.home.path,
                routes: [
                  GoRoute(
                    name: AppRoutes.home.name,
                    path: AppRoutes.home.path,
                    builder: (_, state) => const HomePage(),
                  ),
                  GoRoute(
                    name: AppRoutes.weather_detail.name,
                    path: AppRoutes.weather_detail.path,
                    builder: (context, state) => const WeatherDetail(),
                  ),
                ],
              ),
              StatefulShellBranch(
                initialLocation: AppRoutes.history.path,
                routes: [
                  GoRoute(
                    name: AppRoutes.history.name,
                    path: AppRoutes.history.path,
                    builder: (_, state) => const WeatherHistory(),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
}
