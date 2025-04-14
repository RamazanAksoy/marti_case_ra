import 'package:marti_case_ra/core/extension/extension.dart';

class ProductConstants {
  ProductConstants._init();
  static ProductConstants? _instace;
  static ProductConstants get instance => _instace ??= ProductConstants._init();

  String martiLogo = 'marti'.toPNG;
  String darkMapStyle = 'dark_map'.toJson;
  String lightMapStyle = '[]';
}
