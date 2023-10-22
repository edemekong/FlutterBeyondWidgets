// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:openweather_app/data/models/city.dart';

class Weather {
  final int id;
  final String main;
  final String description;
  final String icon;
  final int dt;
  final double temp;

  final Location? location;


  String get weatherIconUrl => "https://openweathermap.org/img/wn/$icon@2x.png";
  Weather( {
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
    required this.dt,
    required this.temp,

    this.location,
  });


  

  Weather copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
    int? dt,
    double? temp,
    Location? location,
  }) {
    return Weather(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      dt: dt ?? this.dt,
      temp: temp ?? this.temp,
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
      'temp': temp,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'] as int,
      main: map['main'] as String,
      description: map['description'] as String,
      icon: map['icon'] as String,
      dt: map['dt'] ??0,
      temp: map['temp']??0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) => Weather.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Weather(id: $id, main: $main, description: $description, icon: $icon, dt: $dt, temp: $temp)';
  }

  @override
  bool operator ==(covariant Weather other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.main == main &&
      other.description == description &&
      other.icon == icon &&
      other.dt == dt &&
      other.temp == temp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      main.hashCode ^
      description.hashCode ^
      icon.hashCode ^
      dt.hashCode ^
      temp.hashCode;
  }
}
