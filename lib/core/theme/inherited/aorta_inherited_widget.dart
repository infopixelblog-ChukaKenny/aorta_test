import 'package:aorta/core/theme/colors/aorta_colors.dart';
import 'package:flutter/material.dart';

/// An [InheritedWidget] that provides the app's custom [CheckscoresColors]
/// down the widget tree.
///
/// Use [CheckscoresTheme.of(context)] to access the current theme's colors.
class AortaTheme extends InheritedWidget {
  /// The specific color palette for the current theme (light or dark).
  final AortaColors colors;

  const AortaTheme({
    Key? key,
    required this.colors,
    required Widget child,
  }) : super(key: key, child: child);

  /// Retrieves the nearest [CheckscoresColors] from the widget tree.
  ///
  /// This method registers the given [context] for updates when the
  /// [CheckscoresTheme] changes.
  static AortaColors of(BuildContext context) {
    // Find the nearest CheckscoresTheme ancestor
    final AortaTheme? result =
    context.dependOnInheritedWidgetOfExactType<AortaTheme>();

    // Assert that a theme was found.
    assert(result != null, 'No CheckscoresTheme found in context');
    return result!.colors;
  }

  /// Determines if widgets that depend on this [InheritedWidget] should
  /// be rebuilt.
  ///
  /// This implementation checks if the [colors] object instance has changed,
  /// which is exactly what happens when switching from
  /// [LightCheckscoresColors] to [DarkCheckscoresColors].
  @override
  bool updateShouldNotify(AortaTheme oldWidget) {
    return colors != oldWidget.colors;
  }
}