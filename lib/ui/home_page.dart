import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openweather_app/data/states/home_weather_provider.dart';
import 'package:openweather_app/data/states/search_bar_state.dart';
import 'package:openweather_app/ui/components/location_search_bar.dart';
import 'package:openweather_app/ui/components/weather_card.dart';


class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weathers = ref.watch(homeWeatherProvider);
    final homeNotifier = ref.read(homeWeatherProvider.notifier);
    final searchBarNotifier = ref.read(searchBarStateProvider.notifier);
    final locations = ref.watch(searchBarStateProvider);


    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Weather",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 20 * 0.25),
                  SearchLocationBar(
                    onSearch: searchBarNotifier.onSearchLocation,
                    locations: locations,
                    onLocationSelected: homeNotifier.onSelectLocation,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: weathers.length,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemBuilder: (context, index) =>  Padding(
                  padding:const EdgeInsets.only(bottom: 15),
                  child: WeatherCard(weather: weathers[index],),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
