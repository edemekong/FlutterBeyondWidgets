import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openweather_app/data/models/weather.dart';

extension on String {
  String get capitalize {
    return split(" ").map((str) => toBeginningOfSentenceCase(str)).join(" ");
  }
}

class WeatherCard extends StatelessWidget {
  final Weather weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(12));

    final celsius = (weather.temp - 273.15).round();
    final date = DateTime.fromMillisecondsSinceEpoch(weather.dt * 1000);
    final formattedDate = DateFormat("HH:MM a - EEEE, MMMM d'", "en_US").format(date);
    
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: radius,
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${weather.location!.name}, ${weather.location!.state}",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                        ),
                        const SizedBox(height: 2.5),
                        Text(
                          formattedDate,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "$celsius°",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    weather.description.capitalize,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).unselectedWidgetColor,
                        ),
                  ),
                  const Spacer(),
                  Text(
                    "H:12° L:26°",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).unselectedWidgetColor,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -35,
          right: -35,
          child: Image.network(
            weather.weatherIconUrl,
            height: 80,
          ),
        ),
      ],
    );
  }
}
