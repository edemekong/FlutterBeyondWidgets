// ignore_for_file: constant_identifier_names

enum AppRoutes { home, history, weather_detail }

extension AppRouteExtension on AppRoutes {
  get path {
    return switch (this) {
      AppRoutes.home => '/home',
      AppRoutes.history => '/weather-history',
      AppRoutes.weather_detail => '/weather-detail',
    };
  }
}