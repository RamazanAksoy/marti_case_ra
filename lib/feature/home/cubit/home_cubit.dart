import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:marti_case_ra/core/extension/extension.dart';

import '../../../core/cache/locale_manager.dart';
import '../../../product/constans/product_constants.dart';
import '../../../product/data/route_repo.dart';
import '../../../product/enums/preferences_types.dart';
import '../model/route_point.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final RouteRepository _repository = RouteRepository();

  HomeCubit()
    : super(
        HomeState(markers: {}, routePoints: [], isTracking: false, initialPosition: const CameraPosition(target: LatLng(41.0568, 28.8932), zoom: 15)),
      );

  void initialize() async {
    await _loadRoute();
    await _currentLocation();
  }

  Future<void> _currentLocation() async {
    bg.Location currentLocation = await bg.BackgroundGeolocation.getCurrentPosition();
    moveCamera(LatLng(currentLocation.coords.latitude, currentLocation.coords.longitude));
  }

  Future<void> themeChangeMap() async {
    final isDark = LocaleManager.instance.getBool(PreferencesTypes.theme.name);
    String darkMapStyle = await rootBundle.loadString(ProductConstants.instance.darkMapStyle);
    state.controller?.setMapStyle(isDark ? darkMapStyle : ProductConstants.instance.lightMapStyle);
  }

  Future<void> _startBackgroundLocation() async {
    await bg.BackgroundGeolocation.ready(bg.Config(distanceFilter: 1));
    bg.BackgroundGeolocation.start();
    bg.BackgroundGeolocation.onLocation((bg.Location location) async {
      if (state.isTracking) {
        moveCamera(LatLng(location.coords.latitude, location.coords.longitude));
        final latlng = LatLng(location.coords.latitude, location.coords.longitude);
        if (state.routePoints.isEmpty || state.routePoints.last.toLatLng.distanceTo(latlng) >= 100.0) {
          final newPoint = await _getRoutePoint(latlng.latitude, latlng.longitude);
          final updatedPoints = [...state.routePoints, newPoint];
          final updatedMarkers = {
            ...state.markers,
            Marker(
              markerId: MarkerId(location.timestamp.toString()),
              position: latlng,
              infoWindow: InfoWindow(title: newPoint.title, snippet: newPoint.address),
            ),
          };

          emit(state.copyWith(routePoints: updatedPoints, markers: updatedMarkers));
          await _repository.saveRoute(updatedPoints);
        }
      }
    });
  }

  Future<void> moveCamera(LatLng target) async {
    final controller = state.controller;
    if (controller != null) {
      await controller.animateCamera(CameraUpdate.newLatLng(target));
    }
  }

  Future<RoutePoint> _getRoutePoint(double lat, double lng) async {
    final placemarks = await placemarkFromCoordinates(lat, lng);
    final p = placemarks.first;
    return RoutePoint(
      latitude: lat,
      longitude: lng,
      address: '${p.street}, ${p.subLocality}, ${p.administrativeArea}, ${p.postalCode}',
      title: '${p.subAdministrativeArea}, ${p.country}',
    );
  }

  Future<void> startTracking() async {
    await _startBackgroundLocation();
    emit(state.copyWith(isTracking: true));
  }

  void stopTracking() => emit(state.copyWith(isTracking: false));

  Future<void> _loadRoute() async {
    final points = await _repository.loadRoute();
    final markers =
        points
            .map(
              (point) => Marker(
                markerId: MarkerId('${point.latitude},${point.longitude}'),
                position: point.toLatLng,
                infoWindow: InfoWindow(title: point.title, snippet: point.address),
              ),
            )
            .toSet();
    emit(state.copyWith(routePoints: points, markers: markers));
  }

  Future<void> resetRoute() async {
    await _repository.clearRoute();
    emit(state.copyWith(routePoints: [], markers: {}));
  }

  Future<void> setMapController(GoogleMapController controller) async {
    emit(state.copyWith(controller: controller));
    await themeChangeMap();
  }
}
