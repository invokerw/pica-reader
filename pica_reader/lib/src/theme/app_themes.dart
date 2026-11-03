import 'package:flutter/material.dart';

/// Colours of one brightness variant of a theme.
///
/// The values come straight from the rendered design previews in
/// `design/theme-previews`, so what ships matches what was picked.
@immutable
class AppPalette {
  const AppPalette({
    required this.surface,
    required this.container,
    required this.card,
    required this.nav,
    required this.primary,
    required this.onPrimary,
    required this.text,
    required this.muted,
    required this.border,
    required this.chip,
    required this.chipText,
  });

  /// Page background.
  final Color surface;

  /// Section background: avatars, chips' neighbours, input fills, sheets.
  final Color container;

  /// Cards and dialogs.
  final Color card;

  /// Navigation bar background.
  final Color nav;

  final Color primary;
  final Color onPrimary;

  /// Body text.
  final Color text;

  /// Secondary text: authors, counts, hints, inactive icons.
  final Color muted;

  /// Hairlines, dividers, outlines.
  final Color border;

  /// Unselected chip fill and its label.
  final Color chip;
  final Color chipText;
}

/// A complete look: one accent family with a day and a night palette.
@immutable
class AppTheme {
  const AppTheme({
    required this.id,
    required this.name,
    required this.english,
    required this.tagline,
    required this.radius,
    required this.light,
    required this.dark,
    this.serifTitles = false,
  });

  final String id;
  final String name;
  final String english;
  final String tagline;

  /// Corner radius of the whole interface (6 for the print-like themes,
  /// 16 for the softest one).
  final double radius;

  final AppPalette light;
  final AppPalette dark;

  /// Print-inspired themes use a serif face for headings.
  final bool serifTitles;

  AppPalette paletteFor(Brightness brightness) =>
      brightness == Brightness.dark ? dark : light;

  String get label => '$name $english';
}

const String kDefaultThemeId = 'sakura';

const List<AppTheme> kAppThemes = <AppTheme>[
  AppTheme(
    id: 'sakura',
    name: '樱花粉',
    english: 'SAKURA',
    tagline: '延续品牌粉，奶油白打底，最接近现在的界面',
    radius: 14,
    light: AppPalette(
      surface: Color(0xFFFFF9FB),
      container: Color(0xFFFBEEF2),
      card: Color(0xFFFFFFFF),
      nav: Color(0xFFFFF4F7),
      primary: Color(0xFFE0537B),
      onPrimary: Color(0xFFFFFFFF),
      text: Color(0xFF2C1B21),
      muted: Color(0xFF9A7782),
      border: Color(0xFFF2DDE4),
      chip: Color(0xFFFBE9EE),
      chipText: Color(0xFF7C5561),
    ),
    dark: AppPalette(
      surface: Color(0xFF141013),
      container: Color(0xFF1E1619),
      card: Color(0xFF221A1E),
      nav: Color(0xFF1A1417),
      primary: Color(0xFFF7849F),
      onPrimary: Color(0xFF2A0B14),
      text: Color(0xFFF4E7EB),
      muted: Color(0xFFA48991),
      border: Color(0xFF2C2126),
      chip: Color(0xFF241B1F),
      chipText: Color(0xFFC9A9B2),
    ),
  ),
  AppTheme(
    id: 'ink',
    name: '墨水夜',
    english: 'INK',
    tagline: '和纸白配朱砂红，小圆角与衬线标题，像纸质文库本',
    radius: 6,
    serifTitles: true,
    light: AppPalette(
      surface: Color(0xFFFAF9F4),
      container: Color(0xFFF1EFE6),
      card: Color(0xFFFFFFFF),
      nav: Color(0xFFF7F5EE),
      primary: Color(0xFFC0342C),
      onPrimary: Color(0xFFFFFFFF),
      text: Color(0xFF191918),
      muted: Color(0xFF7E7C74),
      border: Color(0xFFE3E0D5),
      chip: Color(0xFFF0EDE4),
      chipText: Color(0xFF5F5D56),
    ),
    dark: AppPalette(
      surface: Color(0xFF0B0B0C),
      container: Color(0xFF141416),
      card: Color(0xFF17171A),
      nav: Color(0xFF101012),
      primary: Color(0xFFE75A4E),
      onPrimary: Color(0xFF1A0705),
      text: Color(0xFFECEBE6),
      muted: Color(0xFF8B8983),
      border: Color(0xFF252528),
      chip: Color(0xFF1B1B1E),
      chipText: Color(0xFFB4B2AB),
    ),
  ),
  AppTheme(
    id: 'glacier',
    name: '海盐蓝',
    english: 'GLACIER',
    tagline: '冷调冰蓝，干净克制，最接近系统原生感',
    radius: 14,
    light: AppPalette(
      surface: Color(0xFFF5F9FC),
      container: Color(0xFFE6EFF7),
      card: Color(0xFFFFFFFF),
      nav: Color(0xFFEDF4FA),
      primary: Color(0xFF2E6FB7),
      onPrimary: Color(0xFFFFFFFF),
      text: Color(0xFF132030),
      muted: Color(0xFF71879A),
      border: Color(0xFFDCE8F2),
      chip: Color(0xFFE8F0F7),
      chipText: Color(0xFF4C6A85),
    ),
    dark: AppPalette(
      surface: Color(0xFF0A1117),
      container: Color(0xFF121C24),
      card: Color(0xFF16212A),
      nav: Color(0xFF0E1720),
      primary: Color(0xFF74A9E6),
      onPrimary: Color(0xFF05131F),
      text: Color(0xFFDCE7F1),
      muted: Color(0xFF7F94A4),
      border: Color(0xFF1F2B35),
      chip: Color(0xFF16212A),
      chipText: Color(0xFFA6BBCB),
    ),
  ),
  AppTheme(
    id: 'sepia',
    name: '旧纸页',
    english: 'SEPIA',
    tagline: '牛皮纸暖黄，护眼耐看，适合长时间翻页',
    radius: 8,
    serifTitles: true,
    light: AppPalette(
      surface: Color(0xFFF5EDDC),
      container: Color(0xFFEDE1CB),
      card: Color(0xFFFBF4E6),
      nav: Color(0xFFF1E7D4),
      primary: Color(0xFF96632F),
      onPrimary: Color(0xFFFFF8EC),
      text: Color(0xFF33281B),
      muted: Color(0xFF88745A),
      border: Color(0xFFE2D4B8),
      chip: Color(0xFFEDE1CB),
      chipText: Color(0xFF5E4B34),
    ),
    dark: AppPalette(
      surface: Color(0xFF16120E),
      container: Color(0xFF201A14),
      card: Color(0xFF221B14),
      nav: Color(0xFF1A150F),
      primary: Color(0xFFD7A462),
      onPrimary: Color(0xFF2B1D0C),
      text: Color(0xFFEBE0CC),
      muted: Color(0xFF95846B),
      border: Color(0xFF2C241A),
      chip: Color(0xFF221B14),
      chipText: Color(0xFFC3B196),
    ),
  ),
  AppTheme(
    id: 'aurora',
    name: '极光紫',
    english: 'AURORA',
    tagline: '紫罗兰加青色荧光，夜间模式下最出彩',
    radius: 16,
    light: AppPalette(
      surface: Color(0xFFF8F6FE),
      container: Color(0xFFEFEAFB),
      card: Color(0xFFFFFFFF),
      nav: Color(0xFFF2EEFC),
      primary: Color(0xFF6B4BE0),
      onPrimary: Color(0xFFFFFFFF),
      text: Color(0xFF1A1630),
      muted: Color(0xFF7B7391),
      border: Color(0xFFE6E0F7),
      chip: Color(0xFFEFEAFB),
      chipText: Color(0xFF574A82),
    ),
    dark: AppPalette(
      surface: Color(0xFF0C0A14),
      container: Color(0xFF151126),
      card: Color(0xFF181330),
      nav: Color(0xFF100D1D),
      primary: Color(0xFFA78BFA),
      onPrimary: Color(0xFF100A26),
      text: Color(0xFFE7E3F6),
      muted: Color(0xFF8C86A4),
      border: Color(0xFF231C3C),
      chip: Color(0xFF181330),
      chipText: Color(0xFFB5ACD6),
    ),
  ),
  AppTheme(
    id: 'moss',
    name: '苔绿',
    english: 'MOSS',
    tagline: '低饱和苔绿，最安静，不抢封面的颜色',
    radius: 12,
    light: AppPalette(
      surface: Color(0xFFF4F7F1),
      container: Color(0xFFE5EDE2),
      card: Color(0xFFFFFFFF),
      nav: Color(0xFFEDF3EA),
      primary: Color(0xFF45704F),
      onPrimary: Color(0xFFFFFFFF),
      text: Color(0xFF1B241D),
      muted: Color(0xFF74806F),
      border: Color(0xFFDCE7D8),
      chip: Color(0xFFE7EEE3),
      chipText: Color(0xFF4C5F4E),
    ),
    dark: AppPalette(
      surface: Color(0xFF0E1410),
      container: Color(0xFF161F19),
      card: Color(0xFF18231C),
      nav: Color(0xFF111A14),
      primary: Color(0xFF8CBE99),
      onPrimary: Color(0xFF08170D),
      text: Color(0xFFDDE8DF),
      muted: Color(0xFF87948B),
      border: Color(0xFF1F2B22),
      chip: Color(0xFF18231C),
      chipText: Color(0xFFA9B8AC),
    ),
  ),
];

/// Never throws: an unknown or empty id (a typo in settings.json, a theme
/// removed later) falls back to the default instead of breaking the UI.
AppTheme appThemeById(String? id) {
  if (id != null) {
    for (final theme in kAppThemes) {
      if (theme.id == id) return theme;
    }
  }
  return kAppThemes.first;
}

const Map<ThemeMode, String> kThemeModeLabels = <ThemeMode, String>{
  ThemeMode.system: '跟随系统',
  ThemeMode.light: '日间',
  ThemeMode.dark: '夜间',
};
