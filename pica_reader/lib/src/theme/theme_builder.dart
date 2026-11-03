import 'package:flutter/material.dart';

import 'app_themes.dart';

/// Handy values the widgets need that are not part of [ColorScheme].
@immutable
class PicaTokens extends ThemeExtension<PicaTokens> {
  const PicaTokens({
    required this.radius,
    required this.coverRadius,
    required this.border,
    required this.muted,
  });

  final double radius;

  /// Radius for cover thumbnails; follows the theme so the print-like themes
  /// stay sharp while the soft ones round off.
  final double coverRadius;

  final Color border;
  final Color muted;

  static const PicaTokens fallback = PicaTokens(
    radius: 12,
    coverRadius: 12,
    border: Color(0xFFE4E4E7),
    muted: Color(0xFF8A8A92),
  );

  static PicaTokens of(BuildContext context) =>
      Theme.of(context).extension<PicaTokens>() ?? fallback;

  @override
  PicaTokens copyWith({
    double? radius,
    double? coverRadius,
    Color? border,
    Color? muted,
  }) {
    return PicaTokens(
      radius: radius ?? this.radius,
      coverRadius: coverRadius ?? this.coverRadius,
      border: border ?? this.border,
      muted: muted ?? this.muted,
    );
  }

  @override
  PicaTokens lerp(covariant ThemeExtension<PicaTokens>? other, double t) {
    if (other is! PicaTokens) return this;
    return PicaTokens(
      radius: radius + (other.radius - radius) * t,
      coverRadius: coverRadius + (other.coverRadius - coverRadius) * t,
      border: Color.lerp(border, other.border, t) ?? border,
      muted: Color.lerp(muted, other.muted, t) ?? muted,
    );
  }
}

/// ThemeData is rebuilt on every settings change if we let it; the pair for a
/// given theme never changes, so build it once.
final Map<String, ThemeData> _cache = <String, ThemeData>{};

ThemeData buildAppTheme(AppTheme theme, Brightness brightness) {
  final key = '${theme.id}/${brightness.name}';
  return _cache[key] ??= _build(theme, brightness);
}

ThemeData _build(AppTheme theme, Brightness brightness) {
  final p = theme.paletteFor(brightness);
  final radius = theme.radius;
  // Soft palettes get pill-shaped chips; print-like ones stay nearly square.
  final chipRadius = radius >= 12 ? 999.0 : radius + 3;

  final scheme = ColorScheme.fromSeed(
    seedColor: p.primary,
    brightness: brightness,
  ).copyWith(
    primary: p.primary,
    onPrimary: p.onPrimary,
    secondary: p.primary,
    onSecondary: p.onPrimary,
    secondaryContainer: p.chip,
    onSecondaryContainer: p.chipText,
    surface: p.surface,
    onSurface: p.text,
    onSurfaceVariant: p.muted,
    outline: p.muted,
    outlineVariant: p.border,
    surfaceDim: p.surface,
    surfaceBright: p.card,
    surfaceContainerLowest: p.surface,
    surfaceContainerLow: p.card,
    surfaceContainer: p.container,
    surfaceContainerHigh: p.container,
    surfaceContainerHighest: p.container,
    inverseSurface: p.text,
    onInverseSurface: p.surface,
    surfaceTint: Colors.transparent,
  );

  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  var textTheme = base.textTheme.apply(
    bodyColor: p.text,
    displayColor: p.text,
  );

  if (theme.serifTitles) {
    const serif = 'SimSun';
    const serifFallback = <String>[
      'Source Han Serif SC',
      'Noto Serif CJK SC',
      'Source Han Serif CN',
      'Songti SC',
      'serif',
    ];
    textTheme = textTheme.copyWith(
      headlineSmall: textTheme.headlineSmall?.copyWith(
        fontFamily: serif,
        fontFamilyFallback: serifFallback,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: textTheme.titleLarge?.copyWith(
        fontFamily: serif,
        fontFamilyFallback: serifFallback,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
      titleMedium: textTheme.titleMedium?.copyWith(
        fontFamily: serif,
        fontFamilyFallback: serifFallback,
        fontWeight: FontWeight.w600,
      ),
    );
  } else {
    textTheme = textTheme.copyWith(
      titleLarge: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
      titleMedium: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  final tokens = PicaTokens(
    radius: radius,
    coverRadius: radius,
    border: p.border,
    muted: p.muted,
  );

  return base.copyWith(
    scaffoldBackgroundColor: p.surface,
    canvasColor: p.surface,
    primaryColor: p.primary,
    textTheme: textTheme,
    dividerColor: p.border,
    dividerTheme: DividerThemeData(color: p.border, thickness: 1, space: 1),
    extensions: <ThemeExtension<dynamic>>[tokens],
    appBarTheme: AppBarTheme(
      centerTitle: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: p.surface,
      surfaceTintColor: Colors.transparent,
      foregroundColor: p.text,
      iconTheme: IconThemeData(color: p.text, size: 22),
      actionsIconTheme: IconThemeData(color: p.text, size: 22),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: p.text,
        fontSize: 21,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: p.nav,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      height: 64,
      indicatorColor: p.primary.withValues(alpha: 0.16),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith<TextStyle?>((states) {
        final selected = states.contains(WidgetState.selected);
        return TextStyle(
          fontSize: 11.5,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          color: selected ? p.primary : p.muted,
        );
      }),
      iconTheme: WidgetStateProperty.resolveWith<IconThemeData?>((states) {
        final selected = states.contains(WidgetState.selected);
        return IconThemeData(
          size: 22,
          color: selected ? p.primary : p.muted,
        );
      }),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: p.surface,
      elevation: 0,
      indicatorColor: p.primary.withValues(alpha: 0.14),
      indicatorShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      selectedIconTheme: IconThemeData(color: p.primary, size: 24),
      unselectedIconTheme: IconThemeData(color: p.muted, size: 23),
      selectedLabelTextStyle: TextStyle(
        color: p.primary,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: TextStyle(color: p.muted, fontSize: 12),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: p.chip,
      selectedColor: p.primary,
      disabledColor: p.container,
      secondarySelectedColor: p.primary,
      showCheckmark: false,
      checkmarkColor: p.onPrimary,
      labelStyle: TextStyle(
        color: p.chipText,
        fontSize: 12.5,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: TextStyle(
        color: p.onPrimary,
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
      side: BorderSide(color: p.border),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(chipRadius),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      labelPadding: const EdgeInsets.symmetric(horizontal: 2),
      elevation: 0,
      pressElevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
    cardTheme: CardThemeData(
      color: p.card,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius + 2),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius + 6),
      ),
      titleTextStyle: textTheme.titleMedium?.copyWith(
        color: p.text,
        fontWeight: FontWeight.w600,
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: p.card,
      modalBackgroundColor: p.card,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(radius + 6)),
      ),
    ),
    listTileTheme: ListTileThemeData(
      iconColor: p.muted,
      textColor: p.text,
      titleTextStyle: textTheme.bodyLarge?.copyWith(
        color: p.text,
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: textTheme.bodyMedium?.copyWith(color: p.muted),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: p.primary,
        foregroundColor: p.onPrimary,
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: p.primary),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: p.primary,
        side: BorderSide(color: p.border),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          return states.contains(WidgetState.selected)
              ? p.primary
              : Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          return states.contains(WidgetState.selected) ? p.onPrimary : p.muted;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
          return BorderSide(
            color: states.contains(WidgetState.selected) ? p.primary : p.border,
          );
        }),
        textStyle: const WidgetStatePropertyAll<TextStyle>(
          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        shape: WidgetStatePropertyAll<OutlinedBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        ),
      ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: p.primary,
      linearTrackColor: p.container,
      circularTrackColor: p.container,
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: p.text,
      contentTextStyle: TextStyle(color: p.surface, fontSize: 13.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      elevation: 2,
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: p.container,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      hintStyle: TextStyle(color: p.muted, fontSize: 14),
      helperStyle: TextStyle(color: p.muted, fontSize: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: p.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: p.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: BorderSide(color: p.primary, width: 1.6),
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return states.contains(WidgetState.selected) ? p.onPrimary : p.muted;
      }),
      trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return states.contains(WidgetState.selected) ? p.primary : p.container;
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith<Color?>((states) {
        return states.contains(WidgetState.selected) ? p.primary : p.border;
      }),
    ),
    iconTheme: IconThemeData(color: p.text),
  );
}
