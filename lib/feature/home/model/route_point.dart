import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutePoint {
  final double latitude;
  final double longitude;
  final String address;
  final String title;

  RoutePoint({required this.latitude, required this.longitude, required this.address, required this.title});

  LatLng get toLatLng => LatLng(latitude, longitude);

  Map<String, dynamic> toJson() => {'latitude': latitude, 'longitude': longitude, 'address': address, 'title': title};

  factory RoutePoint.fromJson(Map<String, dynamic> json) =>
      RoutePoint(latitude: json['latitude'], longitude: json['longitude'], address: json['address'], title: json['title']);
}
