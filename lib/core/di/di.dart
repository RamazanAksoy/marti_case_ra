import 'package:marti_case_ra/core/cache/locale_manager.dart';

class DependencyInjection {
  static init() async {
    await Future.wait([LocaleManager.init()]);
  }
}
