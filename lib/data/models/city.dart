// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Location {
  final String name;
  final String country;
  final String state;
  final double lat;
  final double lon;

  Location({
    required this.name,
    required this.country,
    required this.state,
    required this.lat,
    required this.lon,
  });

  Location copyWith({
    String? name,
    String? country,
    String? state,
    double? lat,
    double? lon,
  }) {
    return Location(
      name: name ?? this.name,
      country: country ?? this.country,
      state: state ?? this.state,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'country': country,
      'state': state,
      'lat': lat,
      'lon': lon,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      name: map['name'] ?? "",
      country: map['country'] as String,
      state: map['state'] ?? "",
      lat: map['lat'] ?? 0,
      lon: map['lon'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Location.fromJson(String source) => Location.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Location(name: $name, country: $country, state: $state, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(covariant Location other) {
    if (identical(this, other)) return true;

    return other.name == name && other.country == country && other.state == state && other.lat == lat && other.lon == lon;
  }

  @override
  int get hashCode {
    return name.hashCode ^ country.hashCode ^ state.hashCode ^ lat.hashCode ^ lon.hashCode;
  }
}
