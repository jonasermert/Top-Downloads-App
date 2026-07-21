import 'package:flutter/material.dart';

abstract final class AppColors {
  static const indigo = Color(0xFF5B5CE2);
  static const violet = Color(0xFF8B5CF6);
  static const cyan = Color(0xFF22D3EE);
  static const lightBackground = Color(0xFFF7F7FC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const darkBackground = Color(0xFF0B0D16);
  static const darkSurface = Color(0xFF151824);
}

abstract final class AppSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

abstract final class AppRadius {
  static const md = 12.0;
  static const lg = 18.0;
  static const xl = 24.0;
  static const full = 999.0;
}
