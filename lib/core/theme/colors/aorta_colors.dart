import 'package:flutter/painting.dart';

/// Abstract definition for the AortaColors color theme.
///
/// This class defines the semantic color roles (backgrounds, borders, text, etc.)
/// that are used throughout the application. Concrete implementations,
/// [LightAortaColorsColors] and [DarkAortaColorsColors], provide the specific
/// color values for each theme.
abstract class AortaColors {
  const AortaColors();

  /// Semantic colors for backgrounds.
  AortaColorsBackgroundColors get background;

  /// Semantic colors for borders.
  AortaColorsBorderColors get border;

  /// Semantic colors for foreground elements (like icons).
  AortaColorsForegroundColors get foreground;

  /// Semantic colors specifically for text.
  AortaColorsTextColors get text;

  /// Semantic colors for focus rings.
  AortaColorsFocusColors get focus;
}

// --- Light Mode Implementation ---

/// Light Mode implementation of [AortaColorsColors].
class LightAortaColors extends AortaColors {
  const LightAortaColors();

  @override
  AortaColorsBackgroundColors get background => const _LightBackgroundColors();
  @override
  AortaColorsBorderColors get border => const _LightBorderColors();
  @override
  AortaColorsForegroundColors get foreground => const _LightForegroundColors();
  @override
  AortaColorsTextColors get text => const _LightTextColors();
  @override
  AortaColorsFocusColors get focus => const _LightFocusColors();
}

// --- Dark Mode Implementation ---

/// Dark Mode implementation of [AortaColorsColors].
class DarkAortaColors extends AortaColors {
  const DarkAortaColors();

  @override
  AortaColorsBackgroundColors get background => const _DarkBackgroundColors();
  @override
  AortaColorsBorderColors get border => const _DarkBorderColors();
  @override
  AortaColorsForegroundColors get foreground => const _DarkForegroundColors();
  @override
  AortaColorsTextColors get text => const _DarkTextColors();
  @override
  AortaColorsFocusColors get focus => const _DarkFocusColors();
}

// --- Abstract Semantic Color Groups ---

/// Abstract class for Background colors.
abstract class AortaColorsBackgroundColors {
  Color get bgSecondaryAlt;
  Color get bgSecondaryHover;
  Color get bgSecondarySubtle;
  Color get bgActive;
  Color get bgBrandPrimary;
  Color get bgBrandPrimaryAlt;
  Color get bgBrandSecondary;
  Color get bgBrandSection;
  Color get bgBrandSectionSubtle;
  Color get bgBrandSolid;
  Color get bgBrandSolidHover;
  Color get bgButton;
  Color get bgDisabled;
  Color get bgDisabledSubtle;
  Color get bgErrorPrimary;
  Color get bgErrorSecondary;
  Color get bgOverlay;
  Color get bgPrimary;
  Color get bgSecondary;
  Color get bgPrimarySolid;
  Color get bgPrimaryAlt;
  Color get bgPrimaryHover;
  Color get bgQuaternary;
  Color get bgSecondarySolid;
  Color get bgSuccessSolid;
  Color get bgSuccessPrimary;
  Color get bgSuccessSecondary;
  Color get bgTertiary;
  Color get bgText;
  Color get bgWarningPrimary;
  Color get bgWarningSecondary;
  Color get bgWarningSolid;
}

/// Abstract class for Border colors.
abstract class AortaColorsBorderColors {
  Color get brand;
  Color get brandAlt;
  Color get disabled;
  Color get disabledSubtle;
  Color get error;
  Color get errorSubtle;
  Color get primary;
  Color get secondary;
  Color get secondaryAlt;
  Color get tertiary;
}

/// Abstract class for Foreground (icons, etc.) colors.
abstract class AortaColorsForegroundColors {
  Color get brandPrimary;
  Color get brandPrimaryAlt;
  Color get brandSecondary;
  Color get brandSecondaryAlt;
  Color get disabled;
  Color get disabledSubtle;
  Color get errorPrimary;
  Color get errorSecondary;
  Color get primary;
  Color get quaternary;
  Color get quaternaryHover;
  Color get secondary;
  Color get secondaryAlt;
  Color get successPrimary;
  Color get successSecondary;
  Color get tertiary;
  Color get tertiaryHover;
  Color get warningPrimary;
  Color get warningSecondary;
  Color get white;
}

/// Abstract class for Text-specific colors.
abstract class AortaColorsTextColors {
  Color get brandPrimary;
  Color get brandSecondary;
  Color get brandSecondaryHover;
  Color get brandTertiary;
  Color get brandTertiaryAlt;
  Color get disabled;
  Color get errorPrimary;
  Color get placeholder;
  Color get placeholderSubtle;
  Color get primary;
  Color get primaryOnBrand;
  Color get quaternary;
  Color get quaternaryOnBrand;
  Color get secondary;
  Color get secondaryHover;
  Color get secondaryOnBrand;
  Color get successPrimary;
  Color get tertiary;
  Color get tertiaryHover;
  Color get tertiaryOnBrand;
  Color get warningPrimary;
  Color get white;
}

/// Abstract class for Focus ring colors.
abstract class AortaColorsFocusColors {
  Color get error100;
  Color get gray100;
  Color get gray600;
  Color get primary100;
  Color get primary500;
}

// --- Concrete Light Mode Colors ---

class _LightBackgroundColors implements AortaColorsBackgroundColors {
  const _LightBackgroundColors();
  @override
  Color get bgSecondaryAlt => AortaColorsPalette.gray50;
  @override
  Color get bgSecondaryHover => AortaColorsPalette.gray100;
  @override
  Color get bgSecondarySubtle => AortaColorsPalette.gray25;
  @override
  Color get bgActive => AortaColorsPalette.gray50;
  @override
  Color get bgBrandPrimary => AortaColorsPalette.brand50;
  @override
  Color get bgBrandPrimaryAlt => AortaColorsPalette.brand50;
  @override
  Color get bgBrandSecondary => AortaColorsPalette.brand100;
  @override
  Color get bgBrandSection => AortaColorsPalette.brand800;
  @override
  Color get bgBrandSectionSubtle => AortaColorsPalette.brand700;
  @override
  Color get bgBrandSolid => AortaColorsPalette.brand500;
  @override
  Color get bgBrandSolidHover => AortaColorsPalette.brand700;
  @override
  Color get bgButton => AortaColorsPalette.gray950;
  @override
  Color get bgDisabled => AortaColorsPalette.gray100;
  @override
  Color get bgDisabledSubtle => AortaColorsPalette.gray50;
  @override
  Color get bgErrorPrimary => AortaColorsPalette.error50;
  @override
  Color get bgErrorSecondary => AortaColorsPalette.error600;
  @override
  Color get bgOverlay => AortaColorsPalette.gray950;
  @override
  Color get bgPrimary => AortaColorsPalette.white;
  @override
  Color get bgSecondary => const Color(0xFFFAFAFA); // #FAFAFA
  @override
  Color get bgPrimarySolid => AortaColorsPalette.gray950;
  @override
  Color get bgPrimaryAlt => AortaColorsPalette.white;
  @override
  Color get bgPrimaryHover => AortaColorsPalette.gray50;
  @override
  Color get bgQuaternary => AortaColorsPalette.gray200;
  @override
  Color get bgSecondarySolid => AortaColorsPalette.gray600;
  @override
  Color get bgSuccessSolid => AortaColorsPalette.success600;
  @override
  Color get bgSuccessPrimary => AortaColorsPalette.success50;
  @override
  Color get bgSuccessSecondary => AortaColorsPalette.success100;
  @override
  Color get bgTertiary => AortaColorsPalette.gray100;
  @override
  Color get bgText => AortaColorsPalette.white;
  @override
  Color get bgWarningPrimary => AortaColorsPalette.warning50;
  @override
  Color get bgWarningSecondary => AortaColorsPalette.warning100;
  @override
  Color get bgWarningSolid => AortaColorsPalette.warning600;
}

class _LightBorderColors implements AortaColorsBorderColors {
  const _LightBorderColors();
  @override
  Color get brand => AortaColorsPalette.brand500;
  @override
  Color get brandAlt => AortaColorsPalette.brand600;
  @override
  Color get disabled => AortaColorsPalette.gray300;
  @override
  Color get disabledSubtle => AortaColorsPalette.gray200;
  @override
  Color get error => AortaColorsPalette.error500;
  @override
  Color get errorSubtle => AortaColorsPalette.error300;
  @override
  Color get primary => AortaColorsPalette.gray300;
  @override
  Color get secondary => AortaColorsPalette.gray200;
  @override
  Color get secondaryAlt => AortaColorsPalette.blackAlpha14; // #00000014
  @override
  Color get tertiary => AortaColorsPalette.gray100;
}

class _LightForegroundColors implements AortaColorsForegroundColors {
  const _LightForegroundColors();
  @override
  Color get brandPrimary => AortaColorsPalette.brand600;
  @override
  Color get brandPrimaryAlt => AortaColorsPalette.brand600;
  @override
  Color get brandSecondary => AortaColorsPalette.brand500;
  @override
  Color get brandSecondaryAlt => AortaColorsPalette.brand500;
  @override
  Color get disabled => AortaColorsPalette.gray400;
  @override
  Color get disabledSubtle => AortaColorsPalette.gray300;
  @override
  Color get errorPrimary => AortaColorsPalette.error600;
  @override
  Color get errorSecondary => AortaColorsPalette.error500;
  @override
  Color get primary => AortaColorsPalette.gray900;
  @override
  Color get quaternary => AortaColorsPalette.gray400;
  @override
  Color get quaternaryHover => AortaColorsPalette.gray500;
  @override
  Color get secondary => AortaColorsPalette.gray700;
  @override
  Color get secondaryAlt => AortaColorsPalette.gray800;
  @override
  Color get successPrimary => AortaColorsPalette.success600;
  @override
  Color get successSecondary => AortaColorsPalette.success500;
  @override
  Color get tertiary => AortaColorsPalette.gray600;
  @override
  Color get tertiaryHover => AortaColorsPalette.gray700;
  @override
  Color get warningPrimary => AortaColorsPalette.warning600;
  @override
  Color get warningSecondary => AortaColorsPalette.warning500;
  @override
  Color get white => AortaColorsPalette.white;
}

class _LightTextColors implements AortaColorsTextColors {
  const _LightTextColors();
  @override
  Color get brandPrimary => AortaColorsPalette.brand900;
  @override
  Color get brandSecondary => AortaColorsPalette.brand700;
  @override
  Color get brandSecondaryHover => AortaColorsPalette.brand700;
  @override
  Color get brandTertiary => AortaColorsPalette.brand600;
  @override
  Color get brandTertiaryAlt => AortaColorsPalette.brand600;
  @override
  Color get disabled => AortaColorsPalette.gray500;
  @override
  Color get errorPrimary => AortaColorsPalette.error600;
  @override
  Color get placeholder => AortaColorsPalette.gray500;
  @override
  Color get placeholderSubtle => AortaColorsPalette.gray300;
  @override
  Color get primary => AortaColorsPalette.gray950;
  @override
  Color get primaryOnBrand => AortaColorsPalette.white;
  @override
  Color get quaternary => AortaColorsPalette.gray500;
  @override
  Color get quaternaryOnBrand => AortaColorsPalette.brand300;
  @override
  Color get secondary => AortaColorsPalette.gray700;
  @override
  Color get secondaryHover => AortaColorsPalette.gray800;
  @override
  Color get secondaryOnBrand => AortaColorsPalette.brand200;
  @override
  Color get successPrimary => AortaColorsPalette.success600;
  @override
  Color get tertiary => AortaColorsPalette.gray600;
  @override
  Color get tertiaryHover => AortaColorsPalette.gray700;
  @override
  Color get tertiaryOnBrand => AortaColorsPalette.brand200;
  @override
  Color get warningPrimary => AortaColorsPalette.warning600;
  @override
  Color get white => AortaColorsPalette.white;
}

class _LightFocusColors implements AortaColorsFocusColors {
  const _LightFocusColors();
  @override
  Color get error100 => AortaColorsPalette.error100;
  @override
  Color get gray100 => AortaColorsPalette.gray100;
  @override
  Color get gray600 => AortaColorsPalette.gray600;
  @override
  Color get primary100 => AortaColorsPalette.brand100;
  @override
  Color get primary500 => AortaColorsPalette.brand600;
}

// --- Concrete Dark Mode Colors ---

class _DarkBackgroundColors implements AortaColorsBackgroundColors {
  const _DarkBackgroundColors();
  @override
  Color get bgSecondaryAlt => AortaColorsPalette.gray950;
  @override
  Color get bgSecondaryHover => AortaColorsPalette.gray800;
  @override
  Color get bgSecondarySubtle => AortaColorsPalette.gray900;
  @override
  Color get bgActive => AortaColorsPalette.gray800;
  @override
  Color get bgBrandPrimary => AortaColorsPalette.brand500;
  @override
  Color get bgBrandPrimaryAlt => AortaColorsPalette.gray800;
  @override
  Color get bgBrandSecondary => AortaColorsPalette.brand600;
  @override
  Color get bgBrandSection => AortaColorsPalette.gray800;
  @override
  Color get bgBrandSectionSubtle => AortaColorsPalette.gray950;
  @override
  Color get bgBrandSolid => AortaColorsPalette.brand600;
  @override
  Color get bgBrandSolidHover => AortaColorsPalette.brand500;
  @override
  Color get bgButton => AortaColorsPalette.brand400;
  @override
  Color get bgDisabled => AortaColorsPalette.gray800;
  @override
  Color get bgDisabledSubtle => AortaColorsPalette.gray900;
  @override
  Color get bgErrorPrimary => AortaColorsPalette.error950;
  @override
  Color get bgErrorSecondary => AortaColorsPalette.error600;
  @override
  Color get bgOverlay => AortaColorsPalette.gray800;
  @override
  Color get bgPrimary => AortaColorsPalette.gray950;
  @override
  Color get bgPrimarySolid => AortaColorsPalette.gray900;
  @override
  Color get bgPrimaryAlt => AortaColorsPalette.gray900;
  @override
  Color get bgPrimaryHover => AortaColorsPalette.gray800;
  @override
  Color get bgQuaternary => AortaColorsPalette.gray700;
  @override
  Color get bgSecondarySolid => AortaColorsPalette.gray600;
  @override
  Color get bgSecondary => const Color(0xFF181D27); // #181D27
  @override
  Color get bgSuccessSolid => AortaColorsPalette.success600;
  @override
  Color get bgSuccessPrimary => AortaColorsPalette.success950;
  @override
  Color get bgSuccessSecondary => AortaColorsPalette.success600;
  @override
  Color get bgTertiary => AortaColorsPalette.gray800;
  @override
  Color get bgText => AortaColorsPalette.white;
  @override
  Color get bgWarningPrimary => AortaColorsPalette.warning950;
  @override
  Color get bgWarningSecondary => AortaColorsPalette.warning600;
  @override
  Color get bgWarningSolid => AortaColorsPalette.warning600;
}

class _DarkBorderColors implements AortaColorsBorderColors {
  const _DarkBorderColors();
  @override
  Color get brand => AortaColorsPalette.brand400;
  @override
  Color get brandAlt => AortaColorsPalette.gray700;
  @override
  Color get disabled => AortaColorsPalette.gray700;
  @override
  Color get disabledSubtle => AortaColorsPalette.gray800;
  @override
  Color get error => AortaColorsPalette.error400;
  @override
  Color get errorSubtle => AortaColorsPalette.error500;
  @override
  Color get primary => AortaColorsPalette.gray700;
  @override
  Color get secondary => AortaColorsPalette.gray800;
  @override
  Color get secondaryAlt => AortaColorsPalette.gray800;
  @override
  Color get tertiary => AortaColorsPalette.gray800;
}

class _DarkForegroundColors implements AortaColorsForegroundColors {
  const _DarkForegroundColors();
  @override
  Color get brandPrimary => AortaColorsPalette.brand500;
  @override
  Color get brandPrimaryAlt => AortaColorsPalette.gray300;
  @override
  Color get brandSecondary => AortaColorsPalette.brand500;
  @override
  Color get brandSecondaryAlt => AortaColorsPalette.gray600;
  @override
  Color get disabled => AortaColorsPalette.gray500;
  @override
  Color get disabledSubtle => AortaColorsPalette.gray600;
  @override
  Color get errorPrimary => AortaColorsPalette.error500;
  @override
  Color get errorSecondary => AortaColorsPalette.error500;
  @override
  Color get primary => AortaColorsPalette.white;
  @override
  Color get quaternary => AortaColorsPalette.gray600;
  @override
  Color get quaternaryHover => AortaColorsPalette.gray500;
  @override
  Color get secondary => AortaColorsPalette.gray300;
  @override
  Color get secondaryAlt => AortaColorsPalette.gray200;
  @override
  Color get successPrimary => AortaColorsPalette.success500;
  @override
  Color get successSecondary => AortaColorsPalette.success400;
  @override
  Color get tertiary => AortaColorsPalette.gray400;
  @override
  Color get tertiaryHover => AortaColorsPalette.gray300;
  @override
  Color get warningPrimary => AortaColorsPalette.warning500;
  @override
  Color get warningSecondary => AortaColorsPalette.warning400;
  @override
  Color get white => AortaColorsPalette.white;
}

class _DarkTextColors implements AortaColorsTextColors {
  const _DarkTextColors();
  @override
  Color get brandPrimary => AortaColorsPalette.gray50;
  @override
  Color get brandSecondary => AortaColorsPalette.gray300;
  @override
  Color get brandSecondaryHover => AortaColorsPalette.gray300;
  @override
  Color get brandTertiary => AortaColorsPalette.gray400;
  @override
  Color get brandTertiaryAlt => AortaColorsPalette.gray50;
  @override
  Color get disabled => AortaColorsPalette.gray500;
  @override
  Color get errorPrimary => AortaColorsPalette.error400;
  @override
  Color get placeholder => AortaColorsPalette.gray400;
  @override
  Color get placeholderSubtle => AortaColorsPalette.gray700;
  @override
  Color get primary => AortaColorsPalette.gray50;
  @override
  Color get primaryOnBrand => AortaColorsPalette.gray50;
  @override
  Color get quaternary => AortaColorsPalette.gray400;
  @override
  Color get quaternaryOnBrand => AortaColorsPalette.gray400;
  @override
  Color get secondary => AortaColorsPalette.gray300;
  @override
  Color get secondaryHover => AortaColorsPalette.gray200;
  @override
  Color get secondaryOnBrand => AortaColorsPalette.gray300;
  @override
  Color get successPrimary => AortaColorsPalette.success400;
  @override
  Color get tertiary => AortaColorsPalette.gray400;
  @override
  Color get tertiaryHover => AortaColorsPalette.gray300;
  @override
  Color get tertiaryOnBrand => AortaColorsPalette.gray400;
  @override
  Color get warningPrimary => AortaColorsPalette.warning400;
  @override
  Color get white => AortaColorsPalette.white;
}

class _DarkFocusColors implements AortaColorsFocusColors {
  const _DarkFocusColors();
  @override
  Color get error100 => AortaColorsPalette.error100;
  @override
  Color get gray100 => AortaColorsPalette.gray100;
  @override
  Color get gray600 => AortaColorsPalette.gray600;
  @override
  Color get primary100 => AortaColorsPalette.brand50;
  @override
  Color get primary500 => AortaColorsPalette.brand600;
}

// --- Base Color Palette ---

/// Contains the base color palettes defined in the CSS.
/// These are raw color values that are referenced by the semantic
/// light and dark theme implementations.
class AortaColorsPalette {
  AortaColorsPalette._(); // Private constructor to prevent instantiation

  // Special case colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color blackAlpha14 = Color(0x14000000); // #00000014

  /* Gray Scale */
  static const Color gray25 = Color(0xFFFDFDFD);
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFE9EAEB);
  static const Color gray300 = Color(0xFFD5D7DA);
  static const Color gray400 = Color(0xFFA4A7AE);
  static const Color gray500 = Color(0xFF717680);
  static const Color gray600 = Color(0xFF535862);
  static const Color gray700 = Color(0xFF414651);
  static const Color gray800 = Color(0xFF252B37);
  static const Color gray900 = Color(0xFF181D27);
  static const Color gray950 = Color(0xFF0A0D12);

  /* Brand Colors */
  static const Color brand25 = Color(0xFFFAFEF5);
  static const Color brand50 = Color(0xFFF3FEE7);
  static const Color brand100 = Color(0xFFE4FBCC);
  static const Color brand200 = Color(0xFFD0F8AB);
  static const Color brand300 = Color(0xFFA6EF67);
  static const Color brand400 = Color(0xFF85E13A);
  static const Color brand500 = Color(0xFF77FF00);
  static const Color brand600 = Color(0xFF4CA30D);
  static const Color brand700 = Color(0xFF3B7C0F);
  static const Color brand800 = Color(0xFF326212);
  static const Color brand900 = Color(0xFF2B5314);
  static const Color brand950 = Color(0xFF15290A);

  /* Error Colors */
  static const Color error25 = Color(0xFFFFFBFB);
  static const Color error50 = Color(0xFFFEF3F2);
  static const Color error100 = Color(0xFFFEE4E2);
  static const Color error200 = Color(0xFFFECDCA);
  static const Color error300 = Color(0xFFFDA29B);
  static const Color error400 = Color(0xFFF97066);
  static const Color error500 = Color(0xFFF04438);
  static const Color error600 = Color(0xFFD92D20);
  static const Color error700 = Color(0xFFB42318);
  static const Color error800 = Color(0xFF912018);
  static const Color error900 = Color(0xFF7A271A);
  static const Color error950 = Color(0xFF55160C);

  /* Warning Colors */
  static const Color warning25 = Color(0xFFFFFDF5);
  static const Color warning50 = Color(0xFFFFFAEB);
  static const Color warning100 = Color(0xFFFEF0C7);
  static const Color warning200 = Color(0xFFFEDF89);
  static const Color warning300 = Color(0xFFFEC84B);
  static const Color warning400 = Color(0xFFFDB022);
  static const Color warning500 = Color(0xFFF79009);
  static const Color warning600 = Color(0xFFDC6803);
  static const Color warning700 = Color(0xFFB54708);
  static const Color warning800 = Color(0xFF93370D);
  static const Color warning900 = Color(0xFF7A2E0E);
  static const Color warning950 = Color(0xFF4E1D09);

  /* Success Colors */
  static const Color success25 = Color(0xFFF6FEF9);
  static const Color success50 = Color(0xFFECFDF3);
  static const Color success100 = Color(0xFFD1FADF);
  static const Color success200 = Color(0xFFA6F4C5);
  static const Color success300 = Color(0xFF6CE9A6);
  static const Color success400 = Color(0xFF32D583);
  static const Color success500 = Color(0xFF12B76A);
  static const Color success600 = Color(0xFF039855);
  static const Color success700 = Color(0xFF027A48);
  static const Color success800 = Color(0xFF05603A);
  static const Color success900 = Color(0xFF054F31);
  static const Color success950 = Color(0xFF053321);

  /* Blue gray Colors */
  static const Color blueGray25 = Color(0xFFFCFCFD);
  static const Color blueGray50 = Color(0xFFF8F9FC);
  static const Color blueGray100 = Color(0xFFEAECF5);
  static const Color blueGray200 = Color(0xFFD5D9EB);
  static const Color blueGray300 = Color(0xFFAFB5D9);
  static const Color blueGray400 = Color(0xFF717BBC);
  static const Color blueGray500 = Color(0xFF4E5BA6);
  static const Color blueGray600 = Color(0xFF3E4784);
  static const Color blueGray700 = Color(0xFF363F72);
  static const Color blueGray800 = Color(0xFF293056);
  static const Color blueGray900 = Color(0xFF101323);
  static const Color blueGray950 = Color(0xFF0D0F1C);

  /* Blue light Colors */
  static const Color blueLight25 = Color(0xFFF5FBFF);
  static const Color blueLight50 = Color(0xFFF0F9FF);
  static const Color blueLight100 = Color(0xFFE0F2FE);
  static const Color blueLight200 = Color(0xFFB9E6FE);
  static const Color blueLight300 = Color(0xFF7CD4FD);
  static const Color blueLight400 = Color(0xFF36BFFA);
  static const Color blueLight500 = Color(0xFF0BA5EC);
  static const Color blueLight600 = Color(0xFF0086C9);
  static const Color blueLight700 = Color(0xFF026AA2);
  static const Color blueLight800 = Color(0xFF065986);
  static const Color blueLight900 = Color(0xFF0B4A6F);

  /* Blue Colors */
  static const Color blue25 = Color(0xFFF5FAFF);
  static const Color blue50 = Color(0xFFEFF8FF);
  static const Color blue100 = Color(0xFFD1E9FF);
  static const Color blue200 = Color(0xFFB2DDFF);
  static const Color blue300 = Color(0xFF84CAFF);
  static const Color blue400 = Color(0xFF53B1FD);
  static const Color blue500 = Color(0xFF2E90FA);
  static const Color blue600 = Color(0xFF1570EF);
  static const Color blue700 = Color(0xFF175CD3);
  static const Color blue800 = Color(0xFF1849A9);
  static const Color blue900 = Color(0xFF194185);

  /* Indigo Colors */
  static const Color indigo25 = Color(0xFFF5F8FF);
  static const Color indigo50 = Color(0xFFEEF4FF);
  static const Color indigo100 = Color(0xFFE0EAFF);
  static const Color indigo200 = Color(0xFFC7D7FE);
  static const Color indigo300 = Color(0xFFA4BCFD);
  static const Color indigo400 = Color(0xFF8098F9);
  static const Color indigo500 = Color(0xFF6172F3);
  static const Color indigo600 = Color(0xFF444CE7);
  static const Color indigo700 = Color(0xFF3538CD);
  static const Color indigo800 = Color(0xFF2D31A6);
  static const Color indigo900 = Color(0xFF2D3282);

  /* Purple Colors */
  static const Color purple25 = Color(0xFFFAFAFF);
  static const Color purple50 = Color(0xFFF4F3FF);
  static const Color purple100 = Color(0xFFEBE9FE);
  static const Color purple200 = Color(0xFFD9D6FE);
  static const Color purple300 = Color(0xFFBDB4FE);
  static const Color purple400 = Color(0xFF9B8AFB);
  static const Color purple500 = Color(0xFF7A5AF8);
  static const Color purple600 = Color(0xFF6938EF);
  static const Color purple700 = Color(0xFF5925DC);
  static const Color purple800 = Color(0xFF4A1FB8);
  static const Color purple900 = Color(0xFF3E1C96);

  /* Pink Colors */
  static const Color pink25 = Color(0xFFFEF6FB);
  static const Color pink50 = Color(0xFFFDF2FA);
  static const Color pink100 = Color(0xFFFCE7F6);
  static const Color pink200 = Color(0xFFFCCEEE);
  static const Color pink300 = Color(0xFFFAA7E0);
  static const Color pink400 = Color(0xFFF670C7);
  static const Color pink500 = Color(0xFFEE46BC);
  static const Color pink600 = Color(0xFFDD2590);
  static const Color pink700 = Color(0xFFC11574);
  static const Color pink800 = Color(0xFF9E165F);
  static const Color pink900 = Color(0xFF851651);

  /* Rose Colors */
  static const Color rose25 = Color(0xFFFFF5F6);
  static const Color rose50 = Color(0xFFFFF1F3);
  static const Color rose100 = Color(0xFFFFE4E8);
  static const Color rose200 = Color(0xFFFECDD6);
  static const Color rose300 = Color(0xFFFEA3B4);
  static const Color rose400 = Color(0xFFFD6F8E);
  static const Color rose500 = Color(0xFFF63D68);
  static const Color rose600 = Color(0xFFE31B54);
  static const Color rose700 = Color(0xFFC01048);
  static const Color rose800 = Color(0xFFA11043);
  static const Color rose900 = Color(0xFF89123E);

  /* Orange Colors */
  static const Color orange25 = Color(0xFFFFFFAF5);
  static const Color orange50 = Color(0xFFFFF6ED);
  static const Color orange100 = Color(0xFFFFEAD5);
  static const Color orange200 = Color(0xFFFDDCAB);
  static const Color orange300 = Color(0xFFFEB273);
  static const Color orange400 = Color(0xFFFD853A);
  static const Color orange500 = Color(0xFFFB6514);
  static const Color orange600 = Color(0xFFEC4A0A);
  static const Color orange700 = Color(0xFFC4320A);
  static const Color orange800 = Color(0xFF9C2A10);
  static const Color orange900 = Color(0xFF7E2410);
}