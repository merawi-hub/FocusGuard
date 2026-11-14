import 'package:flutter/material.dart';

class AppColors {
  // Dark Theme Palette (Signature FocusGuard Dark Navy)
  static const Color darkBackground = Color(0xFF0B132B);
  static const Color darkSurface = Color(0xFF111D4A);
  static const Color darkCard = Color(0xFF1C2541);
  static const Color darkCardElevated = Color(0xFF232F55);
  static const Color darkBorder = Color(0xFF2C3E6B);

  // Accents
  static const Color primaryCyan = Color(0xFF48CAE4);
  static const Color primaryBlue = Color(0xFF0077B6);
  static const Color deepNavy = Color(0xFF023E8A);
  static const Color accentPurple = Color(0xFF7209B7);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Text Colors
  static const Color textPrimaryDark = Color(0xFFF8FAFC);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color textMutedDark = Color(0xFF64748B);

  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF1F5F9);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color textPrimaryLight = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF475569);
  static const Color textMutedLight = Color(0xFF94A3B8);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF48CAE4), Color(0xFF0077B6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1C2541), Color(0xFF111D4A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient dangerGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFB91C1C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient warningGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

