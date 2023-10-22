// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openweather_app/data/models/city.dart';

class Weather {
  final int id;
  final Map<String, dynamic>? main;
  final String description;
  final String icon;
  final int dt;

  final Location? location;

  String get weatherIconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";
  Weather({
    required this.id,
     this.main,
    required this.description,
    required this.icon,
    required this.dt,
    this.location,
  });

  Weather copyWith({
    int? id,
    Map<String, dynamic>? main,
    String? description,
    String? icon,
    int? dt,
    Location? location,
  }) {
    return Weather(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      dt: dt ?? this.dt,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
      'dt': dt,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'] as int,
      description: map['description'] as String,
      icon: map['icon'] as String,
      dt: map['dt'] ?? 0,
    );
  }

  @override
  String toString() {
    return 'Weather(id: $id, main: $main, description: $description, icon: $icon, dt: $dt)';
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;

    return other.id == id && other.main == main && other.description == description && other.icon == icon && other.dt == dt;
  }

  @override
  int get hashCode {
    return id.hashCode ^ main.hashCode ^ description.hashCode ^ icon.hashCode ^ dt.hashCode;
  }
}
