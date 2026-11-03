import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_config.dart';
import '../api/models.dart';
import '../state/library.dart';
import '../state/session.dart';
import '../state/settings.dart';
import 'reader_page.dart';
import 'widgets/pica_image.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionController>();
    final settings = context.watch<Settings>();
    final theme = Theme.of(context);
    final user = session.user;

    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: Builder(
        builder: (context) {
          final library = context.watch<Library>();
          final history = library.history.take(6).toList();
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: theme.colorScheme.surfaceContainerHighest,
                      backgroundImage: (user?.avatar.isNotEmpty ?? false)
                          ? NetworkImage(
                              user!.avatar,
                              headers: {'User-Agent': ApiConfig.userAgent},
                            )
                          : null,
                      child: (user?.avatar.isEmpty ?? true)
                          ? const Icon(Icons.person, size: 28)
                          : null,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user?.name ?? '读者', style: theme.textTheme.titleMedium),
                          const SizedBox(height: 2),
                          Text(
                            session.account.isEmpty ? '已登录' : session.account,
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: theme.colorScheme.outline),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.read<SessionController>().signOut(),
                      child: const Text('退出登录'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              if (history.isNotEmpty) ...[
                const _SectionTitle('继续阅读'),
                for (final entry in history)
                  ListTile(
                    leading: SizedBox(
                      width: 44,
                      height: 60,
                      child: PicaImage(
                        url: entry.value.thumb,
                        cacheWidth: 200,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    title: Text(
                      entry.value.comicTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text('第 ${entry.value.order} 话 · 第 ${entry.value.page + 1} 页'),
                    trailing: const Icon(Icons.play_circle_outline),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ReaderPage(
                          comicId: entry.key,
                          comicTitle: entry.value.comicTitle,
                          thumb: entry.value.thumb,
                          episode: Episode(
                            id: '',
                            title: '第 ${entry.value.order} 话',
                            order: entry.value.order,
                          ),
                          initialPage: entry.value.page,
                        ),
                      ),
                    ),
                  ),
                TextButton.icon(
                  onPressed: () => context.read<Library>().clearHistory(),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: const Text('清空阅读记录'),
                ),
                const Divider(height: 1),
              ],
              const _SectionTitle('阅读设置'),
              SwitchListTile(
                title: const Text('纵向翻页'),
                subtitle: const Text('关闭时按横向翻页'),
                value: settings.verticalReader,
                onChanged: (value) => context.read<Settings>().setVerticalReader(value),
              ),
              ListTile(
                title: const Text('画质'),
                subtitle: Text(switch (settings.imageQuality) {
                  'original' => '原图（流量大）',
                  'low' => '低画质（省流量）',
                  _ => '中等画质（默认）',
                }),
                trailing: DropdownButton<String>(
                  value: settings.imageQuality,
                  underline: const SizedBox.shrink(),
                  items: [
                    for (final quality in ApiConfig.imageQualities)
                      DropdownMenuItem(value: quality, child: Text(quality)),
                  ],
                  onChanged: (value) {
                    if (value != null) context.read<Settings>().setImageQuality(value);
                  },
                ),
              ),
              const Divider(height: 1),
              const _SectionTitle('关于'),
              const ListTile(
                title: Text('哔咔阅读器'),
                subtitle: Text('第三方客户端 · 数据来自 picaapi.picacomic.com\n仅供个人学习使用'),
                isThreeLine: true,
              ),
              ListTile(
                title: const Text('设备标识'),
                subtitle: Text(session.api.deviceUuid),
              ),
              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}
