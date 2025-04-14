import 'package:marti_case_ra/core/extension/extension.dart';

class AppImages {
  AppImages._init();
  static AppImages? _instace;
  static AppImages get instance => _instace ??= AppImages._init();

  String martiLogo = 'marti'.toPNG;
}
