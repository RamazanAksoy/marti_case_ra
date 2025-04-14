import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;
import 'package:marti_case_ra/core/extension/extension.dart';
import 'package:marti_case_ra/feature/home/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../product/constans/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<bool> _initialize() async {
    try {
      await bg.BackgroundGeolocation.start();
      if (await Permission.notification.isDenied) {
        await Permission.notification.request();
      }
      int request = await bg.BackgroundGeolocation.requestPermission();
      return request == bg.ProviderChangeEvent.AUTHORIZATION_STATUS_ALWAYS || request == bg.ProviderChangeEvent.AUTHORIZATION_STATUS_WHEN_IN_USE;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _initialize(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildSplashBackground(context);
        } else if (snapshot.data == false) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.showCustomDialog(
              'Error',
              'location permissions not granted',
              onPressedOk: () => exit(0),
              onPressedCancel: () => openAppSettings(),
              cancelTitle: "Settings",
            );
          });
          return _buildSplashBackground(context);
        } else if (snapshot.data == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await Future.delayed(Duration(seconds: 2));
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
          });
          return _buildSplashBackground(context);
        } else {
          return _buildSplashBackground(context);
        }
      },
    );
  }

  Widget _buildSplashBackground(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          image: DecorationImage(fit: BoxFit.none, image: AssetImage(AppImages.instance.martiLogo)),
        ),
      ),
    );
  }
}
