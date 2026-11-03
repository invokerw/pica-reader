import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/settings.dart';
import '../theme/app_themes.dart';
import '../theme/theme_builder.dart';

/// Picks the palette and the light / night behaviour.
class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<Settings>();
    final theme = Theme.of(context);
    final current = appThemeById(settings.themeId);

    return Scaffold(
      appBar: AppBar(title: const Text('外观')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
        children: [
          _Label('显示模式', theme: theme),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<ThemeMode>(
              showSelectedIcon: false,
              style: const ButtonStyle(
                // Compact so the three options stay on one line on phones.
                padding: WidgetStatePropertyAll<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(horizontal: 10),
                ),
                visualDensity: VisualDensity.compact,
              ),
              segments: [
                for (final mode in ThemeMode.values)
                  ButtonSegment<ThemeMode>(
                    value: mode,
                    icon: Icon(_modeIcon(mode), size: 18),
                    label: Text(kThemeModeLabels[mode]!),
                  ),
              ],
              selected: <ThemeMode>{settings.themeMode},
              onSelectionChanged: (selection) {
                context.read<Settings>().setThemeMode(selection.first);
              },
            ),
          ),
          const SizedBox(height: 8),
          Text(
            switch (settings.themeMode) {
              ThemeMode.system => '跟着系统深色开关自动切换日间 / 夜间配色',
              ThemeMode.light => '固定使用日间配色',
              ThemeMode.dark => '固定使用夜间配色',
            },
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          _Label('主题', theme: theme, trailing: current.label),
          const SizedBox(height: 10),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 720
                  ? 3
                  : constraints.maxWidth >= 460
                      ? 2
                      : 1;
              const spacing = 12.0;
              final cardWidth =
                  (constraints.maxWidth - spacing * (columns - 1)) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (final item in kAppThemes)
                    SizedBox(
                      width: cardWidth,
                      child: _ThemeCard(
                        data: item,
                        selected: item.id == current.id,
                        onTap: () => context.read<Settings>().setTheme(item.id),
                      ),
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            '每套主题都带日间与夜间两套配色。阅读器始终保持纯黑背景，不受主题影响。',
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }

  IconData _modeIcon(ThemeMode mode) => switch (mode) {
        ThemeMode.system => Icons.brightness_auto_outlined,
        ThemeMode.light => Icons.light_mode_outlined,
        ThemeMode.dark => Icons.dark_mode_outlined,
      };
}

class _Label extends StatelessWidget {
  const _Label(this.text, {required this.theme, this.trailing});

  final String text;
  final ThemeData theme;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: theme.textTheme.labelLarge
              ?.copyWith(color: theme.colorScheme.primary),
        ),
        const Spacer(),
        if (trailing != null)
          Text(
            trailing!,
            style: theme.textTheme.bodySmall
                ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
      ],
    );
  }
}

class _ThemeCard extends StatelessWidget {
  const _ThemeCard({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final AppTheme data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = PicaTokens.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(data.radius + 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(data.radius + 4),
          border: Border.all(
            color: selected ? theme.colorScheme.primary : tokens.border,
            width: selected ? 1.6 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(data.radius + 3),
              ),
              child: AspectRatio(
                aspectRatio: 1.65,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _PreviewHalf(
                            data: data,
                            brightness: Brightness.light,
                          ),
                        ),
                        Container(width: 1, color: data.light.border),
                        Expanded(
                          child: _PreviewHalf(
                            data: data,
                            brightness: Brightness.dark,
                          ),
                        ),
                      ],
                    ),
                    if (selected)
                      Positioned(
                        right: 6,
                        top: 6,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check,
                            size: 13,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          data.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      if (data.serifTitles)
                        Container(
                          margin: const EdgeInsets.only(left: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '衬线',
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontSize: 9.5,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.tagline,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One half of the miniature: the theme itself, drawn as a page of the app.
class _PreviewHalf extends StatelessWidget {
  const _PreviewHalf({required this.data, required this.brightness});

  final AppTheme data;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final p = data.paletteFor(brightness);
    final cover = BorderRadius.circular(data.radius / 2);

    Widget bar(double factor, {double height = 5}) => Container(
          height: height,
          decoration: BoxDecoration(
            color: p.text.withValues(alpha: factor),
            borderRadius: BorderRadius.circular(height / 2),
          ),
        );

    Widget swatch(Color color) => Container(
          width: double.infinity,
          decoration: BoxDecoration(color: color, borderRadius: cover),
        );

    return ColoredBox(
      color: p.surface,
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: bar(0.7, height: 5)),
                const SizedBox(width: 6),
                Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: p.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                for (var i = 0; i < 3; i++)
                  Container(
                    width: 11,
                    height: 5,
                    margin: const EdgeInsets.only(right: 4),
                    decoration: BoxDecoration(
                      color: i == 0 ? p.primary : p.chip,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 7),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: swatch(Color.lerp(p.container, p.primary, 0.55)!),
                        ),
                        const SizedBox(height: 4),
                        bar(0.45, height: 4),
                      ],
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: swatch(Color.lerp(p.container, p.primary, 0.18)!),
                        ),
                        const SizedBox(height: 4),
                        bar(0.3, height: 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                color: p.nav,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: p.border, width: 0.7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < 3; i++)
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: i == 0 ? p.primary : p.muted,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
