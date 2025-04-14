import 'dart:convert';

import '../../core/cache/locale_manager.dart';
import '../../feature/home/model/route_point.dart';
import '../enums/preferences_types.dart';

class RouteRepository {
  LocaleManager localeManager = LocaleManager.instance;

  Future<void> saveRoute(List<RoutePoint> points) async {
    final list = points.map((e) => jsonEncode(e.toJson())).toList();
    await localeManager.setStringList(PreferencesTypes.savedRoute.name, list);
  }

  Future<List<RoutePoint>> loadRoute() async {
    final list = localeManager.getStringList(PreferencesTypes.savedRoute.name);
    return list.map((e) => RoutePoint.fromJson(jsonDecode(e))).toList();
  }

  Future<void> clearRoute() async => await localeManager.clear(PreferencesTypes.savedRoute.name);
}
