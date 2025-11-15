import 'package:flutter/material.dart';

extension WidgetSpacing on num {
  SizedBox get spacingW => SizedBox(width: this as double);
  SizedBox get spacingH => SizedBox(height: this as double);
}
