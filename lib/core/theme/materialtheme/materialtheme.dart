import 'package:aorta/core/theme/colors/aorta_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// --- Constants from your example ---
final horizontalPadding = EdgeInsets.symmetric(horizontal: 16.w);
final defPadding = 16.w;
final defCornerRadius = 10.w;

// --- Internal Theme Data ---
const _lightColors = LightAortaColors();
const _darkColors = DarkAortaColors();

/// A MaterialColor swatch generated from the Checkscores brand palette.
const MaterialColor checkscoresBrandSwatch = MaterialColor(
  0xFF77FF00, // Primary value: brand-500
  <int, Color>{
    25: AortaColorsPalette.brand25,
    50: AortaColorsPalette.brand50,
    100: AortaColorsPalette.brand100,
    200: AortaColorsPalette.brand200,
    300: AortaColorsPalette.brand300,
    400: AortaColorsPalette.brand400,
    500: AortaColorsPalette.brand500,
    600: AortaColorsPalette.brand600,
    700: AortaColorsPalette.brand700,
    800: AortaColorsPalette.brand800,
    900: AortaColorsPalette.brand900,
    950: AortaColorsPalette.brand950,
  },
);

/// --- LIGHT THEME ---
final aortaThemeLight = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: _lightColors.foreground.brandPrimary,
  // gray-950
  scaffoldBackgroundColor: _lightColors.background.bgSecondary,
  // gray-50
  cardColor: _lightColors.background.bgPrimary,
  // white
  primarySwatch: checkscoresBrandSwatch,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  canvasColor: _lightColors.background.bgSecondary,

  textSelectionTheme:  TextSelectionThemeData(
    cursorColor: _lightColors.focus.primary500,
    selectionColor: _lightColors.focus.primary100.withValues(alpha: 0.9),
    selectionHandleColor:  _lightColors.focus.primary500,
  ),

  // --- Color Scheme ---
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    // Primary (used for buttons, active elements)
    primary: _lightColors.background.bgButton,
    // gray-950
    onPrimary: _lightColors.text.primaryOnBrand,
    // white
    primaryContainer: _lightColors.background.bgBrandPrimary,
    // brand-50
    onPrimaryContainer: _lightColors.text.brandPrimary,
    // brand-900

    // Secondary (accent color)
    secondary: _lightColors.background.bgBrandSolid,
    // brand-500
    onSecondary: _lightColors.text.primaryOnBrand,
    // white
    secondaryContainer: _lightColors.background.bgBrandSecondary,
    // brand-100
    onSecondaryContainer: _lightColors.text.brandSecondary,
    // brand-700

    // Tertiary (another accent, e.g., success)
    tertiary: _lightColors.background.bgSuccessSolid,
    // success-600
    onTertiary: _lightColors.text.white,
    tertiaryContainer: _lightColors.background.bgSuccessPrimary,
    // success-50
    onTertiaryContainer: _lightColors.text.successPrimary,
    // success-600

    // Error
    error: _lightColors.border.error,
    // error-500
    onError: _lightColors.text.white,
    errorContainer: _lightColors.background.bgErrorPrimary,
    // error-50
    onErrorContainer: _lightColors.text.errorPrimary,
    // error-600

    // Surfaces (backgrounds, cards)
    background: _lightColors.background.bgSecondary,
    // gray-50 (#FAFAFA)
    onBackground: _lightColors.text.primary,
    // gray-950
    surface: _lightColors.background.bgPrimary,
    // white
    onSurface: _lightColors.text.primary,
    // gray-950
    surfaceVariant: _lightColors.background.bgTertiary,
    // gray-100
    onSurfaceVariant: _lightColors.text.secondary,
    // gray-700

    // Outlines (borders)
    outline: _lightColors.border.primary,
    // gray-300
    outlineVariant: _lightColors.border.secondary,
    // gray-200
    shadow: AortaColorsPalette.gray900,
    scrim: AortaColorsPalette.gray950.withOpacity(0.5),
    inverseSurface: _darkColors.background.bgPrimary,
    onInverseSurface: _darkColors.text.primary,
    inversePrimary: _darkColors.background.bgButton,
  ),

  // --- Text Theme ---
  // Using Plus Jakarta Sans as defined in the CSS
  textTheme: TextTheme(
    // Example: 2rem (32px), 700 weight
    displayLarge: GoogleFonts.plusJakartaSansTextTheme().displayLarge?.copyWith(
      fontSize: 32.sp,
      color: _lightColors.text.primary,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.plusJakartaSansTextTheme().displayMedium
        ?.copyWith(
          color: _lightColors.text.primary,
          fontWeight: FontWeight.w700,
        ),
    displaySmall: GoogleFonts.plusJakartaSansTextTheme().displaySmall?.copyWith(
      color: _lightColors.text.primary,
      fontWeight: FontWeight.w700,
    ),

    // Example: --text-headline-style (2rem -> 32px, 700 weight)
    headlineLarge: GoogleFonts.plusJakartaSansTextTheme().headlineLarge
        ?.copyWith(
          fontSize: 32.sp,
          color: _lightColors.text.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.01 * 32.sp, // 0.01rem
        ),
    headlineMedium: GoogleFonts.plusJakartaSansTextTheme().headlineMedium
        ?.copyWith(
          color: _lightColors.text.primary,
          fontWeight: FontWeight.w700,
        ),
    headlineSmall: GoogleFonts.plusJakartaSansTextTheme().headlineSmall
        ?.copyWith(
          color: _lightColors.text.primary,
          fontWeight: FontWeight.w700,
        ),

    titleLarge: GoogleFonts.plusJakartaSansTextTheme().titleLarge?.copyWith(
      color: _lightColors.text.primary,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.plusJakartaSansTextTheme().titleMedium?.copyWith(
      color: _lightColors.text.primary,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: GoogleFonts.plusJakartaSansTextTheme().titleSmall?.copyWith(
      color: _lightColors.text.primary,
      fontWeight: FontWeight.w600,
    ),

    // Example: --text-body-style (0.8rem -> 12.8px, 500 weight)
    bodyLarge: GoogleFonts.plusJakartaSansTextTheme().bodyLarge?.copyWith(
      fontSize: 16.sp,
      color: _lightColors.text.secondary,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.plusJakartaSansTextTheme().bodyMedium?.copyWith(
      fontSize: 14.sp,
      color: _lightColors.text.secondary,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.plusJakartaSansTextTheme().bodySmall?.copyWith(
      fontSize: 12.sp,
      color: _lightColors.text.secondary,
      fontWeight: FontWeight.w500,
    ),

    labelLarge: GoogleFonts.plusJakartaSansTextTheme().labelLarge?.copyWith(
      fontSize: 14.sp,
      color: _lightColors.text.tertiary,
    ),
    labelMedium: GoogleFonts.plusJakartaSansTextTheme().labelMedium?.copyWith(
      fontSize: 12.sp,
      color: _lightColors.text.tertiary,
    ),
    labelSmall: GoogleFonts.plusJakartaSansTextTheme().labelSmall?.copyWith(
      fontSize: 11.sp,
      color: _lightColors.text.tertiary,
    ),
  ),

  // --- Component Themes ---
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    backgroundColor: _lightColors.background.bgSecondary,
    foregroundColor: _lightColors.text.primary,
    iconTheme: IconThemeData(color: _lightColors.text.primary, size: 22.w),
    titleTextStyle: GoogleFonts.plusJakartaSansTextTheme().titleMedium
        ?.copyWith(
          color: _lightColors.text.primary,
          fontWeight: FontWeight.w600,
          fontSize: 18.sp,
        ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    fillColor: _lightColors.background.bgPrimary,
    // white
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(color: _lightColors.border.secondary), // gray-200
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(color: _lightColors.border.secondary), // gray-200
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(
        color: _lightColors.border.brand,
        width: 1.5,
      ), // brand-500
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(color: _lightColors.border.error), // error-500
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(color: _lightColors.border.error, width: 1.5),
    ),
    labelStyle: GoogleFonts.plusJakartaSansTextTheme().bodyMedium?.copyWith(
      fontSize: 14.sp,
      color: _lightColors.text.secondary,
    ),
    hintStyle: GoogleFonts.plusJakartaSansTextTheme().bodyMedium?.copyWith(
      color: _lightColors.text.placeholder, // gray-500
    ),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: _lightColors.background.bgBrandPrimary,
      // gray-950
      foregroundColor: _lightColors.text.white,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      textStyle: GoogleFonts.plusJakartaSansTextTheme().bodyMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: _lightColors.text.white,
      ),
      shape: StadiumBorder(),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _lightColors.background.bgButton,
      // gray-950
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 20.w),
      textStyle: GoogleFonts.plusJakartaSansTextTheme().bodyMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: _lightColors.background.bgButton,
      ),
      side: BorderSide(color: _lightColors.background.bgButton, width: 1.5),
      shape: StadiumBorder(),
    ),
  ),

  iconTheme: IconThemeData(
    color: _lightColors.foreground.secondary,
    size: 22.w,
  ),

  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(_lightColors.foreground.secondary),
      iconSize: WidgetStatePropertyAll(20.w),
    ),
  ),

  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return _lightColors.background.bgSuccessSolid; // success-600
      }
      return _lightColors.border.primary; // gray-300
    }),
    thumbColor: WidgetStatePropertyAll(_lightColors.text.white),
  ),

  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defCornerRadius),
    ),
  ),
);

/// --- DARK THEME ---
final aortaThemeDark = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: _darkColors.foreground.brandPrimary,
  // brand-400
  scaffoldBackgroundColor: _darkColors.background.bgSecondary,
  // #181D27
  cardColor: _darkColors.background.bgPrimary,
  // gray-950
  primarySwatch: checkscoresBrandSwatch,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  canvasColor: _darkColors.background.bgSecondary,
  textSelectionTheme:  TextSelectionThemeData(
    cursorColor: _lightColors.focus.primary500,
    selectionColor: _lightColors.focus.primary100.withValues(alpha: 0.9),
    selectionHandleColor:  _lightColors.focus.primary500,
  ),

  // --- Color Scheme ---
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    // Primary (used for buttons, active elements)
    primary: _darkColors.background.bgButton,
    // brand-400
    onPrimary: _darkColors.text.primary,
    // gray-50
    primaryContainer: _darkColors.background.bgBrandPrimaryAlt,
    // gray-800
    onPrimaryContainer: _darkColors.text.brandSecondary,
    // gray-300

    // Secondary (accent color)
    secondary: _darkColors.background.bgBrandSolid,
    // brand-600
    onSecondary: _darkColors.text.primary,
    // gray-50
    secondaryContainer: _darkColors.background.bgBrandPrimaryAlt,
    // gray-800
    onSecondaryContainer: _darkColors.text.brandSecondary,
    // gray-300

    // Tertiary (another accent, e.g., success)
    tertiary: _darkColors.background.bgSuccessSolid,
    // success-600
    onTertiary: _darkColors.text.white,
    tertiaryContainer: _darkColors.background.bgSuccessPrimary,
    // success-950
    onTertiaryContainer: _darkColors.text.successPrimary,
    // success-400

    // Error
    error: _darkColors.border.error,
    // error-400
    onError: _darkColors.text.white,
    errorContainer: _darkColors.background.bgErrorPrimary,
    // error-950
    onErrorContainer: _darkColors.text.errorPrimary,
    // error-400

    // Surfaces (backgrounds, cards)
    background: _darkColors.background.bgSecondary,
    // #181D27
    onBackground: _darkColors.text.primary,
    // gray-50
    surface: _darkColors.background.bgPrimary,
    // gray-950
    onSurface: _darkColors.text.primary,
    // gray-50
    surfaceVariant: _darkColors.background.bgTertiary,
    // gray-800
    onSurfaceVariant: _darkColors.text.secondary,
    // gray-300

    // Outlines (borders)
    outline: _darkColors.border.primary,
    // gray-700
    outlineVariant: _darkColors.border.secondary,
    // gray-800
    shadow: AortaColorsPalette.gray950,
    scrim: AortaColorsPalette.gray800.withOpacity(0.5),
    inverseSurface: _lightColors.background.bgPrimary,
    onInverseSurface: _lightColors.text.primary,
    inversePrimary: _lightColors.background.bgButton,
  ),

  // --- Text Theme ---
  // Inherit styles from light theme but override colors
  textTheme: TextTheme(
    displayLarge: aortaThemeLight.textTheme.displayLarge?.copyWith(
      color: _darkColors.text.primary,
    ),
    displayMedium: aortaThemeLight.textTheme.displayMedium?.copyWith(
      color: _darkColors.text.primary,
    ),
    displaySmall: aortaThemeLight.textTheme.displaySmall?.copyWith(
      color: _darkColors.text.primary,
    ),
    headlineLarge: aortaThemeLight.textTheme.headlineLarge?.copyWith(
      color: _darkColors.text.primary,
    ),
    headlineMedium: aortaThemeLight.textTheme.headlineMedium?.copyWith(
      color: _darkColors.text.primary,
    ),
    headlineSmall: aortaThemeLight.textTheme.headlineSmall?.copyWith(
      color: _darkColors.text.primary,
    ),
    titleLarge: aortaThemeLight.textTheme.titleLarge?.copyWith(
      color: _darkColors.text.primary,
    ),
    titleMedium: aortaThemeLight.textTheme.titleMedium?.copyWith(
      color: _darkColors.text.primary,
    ),
    titleSmall: aortaThemeLight.textTheme.titleSmall?.copyWith(
      color: _darkColors.text.primary,
    ),
    bodyLarge: aortaThemeLight.textTheme.bodyLarge?.copyWith(
      color: _darkColors.text.secondary,
    ),
    bodyMedium: aortaThemeLight.textTheme.bodyMedium?.copyWith(
      color: _darkColors.text.secondary,
    ),
    bodySmall: aortaThemeLight.textTheme.bodySmall?.copyWith(
      color: _darkColors.text.secondary,
    ),
    labelLarge: aortaThemeLight.textTheme.labelLarge?.copyWith(
      color: _darkColors.text.tertiary,
    ),
    labelMedium: aortaThemeLight.textTheme.labelMedium?.copyWith(
      color: _darkColors.text.tertiary,
    ),
    labelSmall: aortaThemeLight.textTheme.labelSmall?.copyWith(
      color: _darkColors.text.tertiary,
    ),
  ),

  // --- Component Themes ---
  appBarTheme: AppBarTheme(
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    backgroundColor: _darkColors.background.bgSecondary,
    foregroundColor: _darkColors.text.primary,
    iconTheme: IconThemeData(color: _darkColors.text.primary, size: 22.w),
    titleTextStyle: aortaThemeLight.appBarTheme.titleTextStyle?.copyWith(
      color: _darkColors.text.primary,
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    fillColor: _darkColors.background.bgPrimaryAlt,
    // gray-900
    filled: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(color: _darkColors.border.secondary), // gray-800
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(color: _darkColors.border.secondary), // gray-800
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(
        color: _darkColors.border.brand,
        width: 1.5,
      ), // brand-400
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(color: _darkColors.border.error), // error-400
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.w),
      borderSide: BorderSide(color: _darkColors.border.error, width: 1.5),
    ),
    labelStyle: aortaThemeLight.inputDecorationTheme.labelStyle?.copyWith(
      color: _darkColors.text.secondary,
    ),
    hintStyle: aortaThemeLight.inputDecorationTheme.hintStyle?.copyWith(
      color: _darkColors.text.placeholder, // gray-400
    ),
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: _darkColors.background.bgBrandPrimary,
      // brand-400
      foregroundColor: _darkColors.text.primary,
      // gray-50
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 20.w),
      textStyle: GoogleFonts.plusJakartaSansTextTheme().bodyMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: _darkColors.text.primary,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defCornerRadius),
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: _darkColors.background.bgButton,
      // brand-400
      padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 20.w),
      textStyle: GoogleFonts.plusJakartaSansTextTheme().bodyMedium?.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: _darkColors.background.bgButton,
      ),
      side: BorderSide(color: _darkColors.background.bgButton, width: 1.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defCornerRadius),
      ),
    ),
  ),

  iconTheme: IconThemeData(color: _darkColors.foreground.secondary, size: 22.w),

  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      iconColor: WidgetStatePropertyAll(_darkColors.foreground.secondary),
      iconSize: WidgetStatePropertyAll(20.w),
    ),
  ),

  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith<Color?>((
      Set<WidgetState> states,
    ) {
      if (states.contains(WidgetState.selected)) {
        return _darkColors.background.bgSuccessSolid; // success-600
      }
      return _darkColors.border.primary; // gray-700
    }),
    thumbColor: WidgetStatePropertyAll(_darkColors.text.white),
  ),

  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defCornerRadius),
    ),
  ),
);
