import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/route_point.dart';

class HomeState {
  final Set<Marker> markers;
  final List<RoutePoint> routePoints;
  final bool isTracking;
  final CameraPosition initialPosition;
  final GoogleMapController? controller;

  HomeState({required this.markers, required this.routePoints, required this.isTracking, required this.initialPosition, this.controller});

  HomeState copyWith({
    Set<Marker>? markers,
    List<RoutePoint>? routePoints,
    bool? isTracking,
    CameraPosition? initialPosition,
    GoogleMapController? controller,
  }) {
    return HomeState(
      markers: markers ?? this.markers,
      routePoints: routePoints ?? this.routePoints,
      isTracking: isTracking ?? this.isTracking,
      initialPosition: initialPosition ?? this.initialPosition,
      controller: controller ?? this.controller,
    );
  }
}
