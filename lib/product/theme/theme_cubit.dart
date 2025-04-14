import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/cache/locale_manager.dart';
import '../enums/preferences_types.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.light) {
    _loadTheme();
  }

  /// Uygulama açıldığında kaydedilmiş temayı yükler
  Future<void> _loadTheme() async {
    final isDark = LocaleManager.instance.getBool(PreferencesTypes.theme.name);
    emit(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  /// Temayı toggle eder (dark <-> light)
  Future<void> toggleTheme() async {
    final newTheme = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await LocaleManager.instance.setBool(PreferencesTypes.theme.name, newTheme == ThemeMode.dark);
    emit(newTheme);
  }

  /// Mevcut temayı ThemeMode olarak döner
  ThemeMode getCurrentTheme() {
    return state;
  }

  /// Şu an karanlık modda mıyız?
  bool isDarkMode() {
    return state == ThemeMode.dark;
  }
}
