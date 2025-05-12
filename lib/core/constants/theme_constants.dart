import 'package:flutter/material.dart';
import '../../config/theme/app_colors.dart';

class ThemeConstants {
  // Text Styles
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingSmall = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  static const TextStyle buttonText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Button Styles
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryBlue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );

  static final ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.primaryBlue,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: AppColors.primaryBlue),
    ),
  );

  static final ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: AppColors.primaryBlue,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  // Card Styles
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.cardBackground,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 8,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Input Decoration
  static final InputDecoration inputDecoration = InputDecoration(
    filled: true,
    fillColor: AppColors.inputBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.7)),
  );

  // App Bar Theme
  static final AppBarTheme appBarTheme = AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
    titleTextStyle: headingSmall,
  );

  // Bottom Navigation Bar Theme
  static final BottomNavigationBarThemeData bottomNavBarTheme =
      BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryDark,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      );

  // Tab Bar Theme
  static final TabBarTheme tabBarTheme = TabBarTheme(
    labelColor: AppColors.primaryBlue,
    unselectedLabelColor: AppColors.textSecondary,
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColors.primaryBlue, width: 3),
    ),
  );

  // Divider Theme
  static final DividerThemeData dividerTheme = DividerThemeData(
    color: AppColors.divider,
    thickness: 1,
    space: 1,
  );

  // Scaffold Background Color
  static const Color scaffoldBackgroundColor = AppColors.background;

  // Progress Indicator Theme
  static final ProgressIndicatorThemeData progressIndicatorTheme =
      ProgressIndicatorThemeData(
        color: AppColors.primaryBlue,
        circularTrackColor: AppColors.primaryBlue.withOpacity(0.2),
        linearTrackColor: AppColors.primaryBlue.withOpacity(0.2),
      );
}
