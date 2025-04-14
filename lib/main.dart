import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marti_case_ra/feature/splash/splash_screen.dart';

import 'core/theme/theme.dart';
import 'product/theme/theme_cubit.dart';

void main() {
  runApp(MultiBlocProvider(providers: [BlocProvider(create: (_) => ThemeCubit())], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, themeMode) {
        return MaterialApp(theme: AppTheme.lightTheme, darkTheme: AppTheme.darkTheme, themeMode: themeMode, home: const SplashScreen());
      },
    );
  }
}
