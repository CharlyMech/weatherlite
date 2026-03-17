import 'package:flutter/material.dart';

class AppAnimations {
  AppAnimations._();

  // Durations
  static const fast = Duration(milliseconds: 200);
  static const medium = Duration(milliseconds: 350);
  static const slow = Duration(milliseconds: 500);

  // Curves
  static const curve = Curves.easeOutCubic;
  static const bounceCurve = Curves.elasticOut;
  static const sharpCurve = Curves.easeInOutCubic;
}
