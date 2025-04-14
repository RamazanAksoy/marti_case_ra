import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constans/app_constants.dart';

extension ContextExtensions on BuildContext {
  void showCustomDialog(
    String title,
    String message, {
    String? okTitle,
    void Function()? onPressedOk,
    String? cancelTitle,
    void Function()? onPressedCancel,
  }) {
    showDialog(
      context: this,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(onPressed: () => onPressedOk?.call(), child: Text(okTitle ?? 'Ok')),
            TextButton(onPressed: () => onPressedCancel?.call(), child: Text(cancelTitle ?? 'Cancel')),
          ],
        );
      },
    );
  }

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;
}

extension LatLngExtension on LatLng {
  double distanceTo(LatLng other) {
    const double earthRadius = 6371000;
    double dLat = _degToRad(other.latitude - latitude);
    double dLon = _degToRad(other.longitude - longitude);
    double a = sin(dLat / 2) * sin(dLat / 2) + cos(_degToRad(latitude)) * cos(_degToRad(other.latitude)) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  double _degToRad(double deg) => deg * (pi / 180.0);
}

extension ImagePngPathExtension on String {
  String get toPNG => '${ApplicationConstants.IMAGE_ASSET_PATH}$this.png';
}
