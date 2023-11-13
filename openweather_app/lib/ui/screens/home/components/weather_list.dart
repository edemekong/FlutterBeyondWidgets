import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:openweather_app/constants/route_paths.dart';
import 'package:openweather_app/data/states/home_weather_provider.dart';
import 'package:openweather_app/ui/components/weather_card.dart';

class WeatherList extends ConsumerWidget {
  const WeatherList({
    super.key,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final weathers = ref.watch(homeWeatherProvider);

    return Builder(builder: (context) {
      if (weathers.isEmpty) {
        return const Center(
          child: Text(
            "Your search weather will appear here",
          ),
        );
      }
      return ListView.builder(
        itemCount: weathers.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
            onTap: (){
              context.push(AppRoutes.weather_detail.path);
            },
            child: WeatherCard(
              weather: weathers[index],
            ),
          ),
        ),
      );
    });
  }
}
