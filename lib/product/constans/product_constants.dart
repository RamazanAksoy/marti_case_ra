import 'package:marti_case_ra/core/extension/extension.dart';

class ProductConstants {
  ProductConstants._();
  static ProductConstants? _instace;
  static ProductConstants get instance => _instace ??= ProductConstants._();

  final String martiLogo = 'marti'.toPNG;
  final String darkMapStyle = 'dark_map'.toJson;
  final String lightMapStyle = '[]';
}
