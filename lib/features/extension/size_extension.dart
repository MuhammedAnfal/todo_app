import 'package:flutter/widgets.dart';

extension SizeExtension on BuildContext {
  double get h => MediaQuery.sizeOf(this).height;
  double get w => MediaQuery.sizeOf(this).width;
}
