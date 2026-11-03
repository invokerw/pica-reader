import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_config.dart';
import '../api/models.dart';
import '../platform/export_service.dart';
import '../state/downloads.dart';
import '../state/library.dart';
import '../state/session.dart';
import '../state/settings.dart';
import '../theme/app_themes.dart';
import 'downloads_page.dart';
import 'reader_page.dart';
import 'theme_page.dart';
import 'widgets/pica_image.dart';

class MePage extends StatelessWidget {
  const MePage({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.watch<SessionController>();
    final settings = context.watch<Settings>();
    final downloads = context.watch<DownloadManager>();
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
              const _SectionTitle('离线'),
              ListTile(
                leading: const Icon(Icons.download_done_outlined),
                title: const Text('离线漫画'),
                subtitle: Text(downloads.comics.isEmpty
                    ? '还没有下载的章节'
                    : '${downloads.totalChapters} 话 · ${formatBytes(downloads.totalBytes)}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const DownloadsPage()),
                ),
              ),
              ListTile(
                title: const Text('保存位置'),
                subtitle: Text(
                  downloads.rootPath.isEmpty
                      ? '未找到可写目录'
                      : '${downloads.rootPath}\n点击修改（留空恢复默认）',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () => _editDownloadRoot(context),
                trailing: IconButton(
                  tooltip: '打开文件夹',
                  onPressed: downloads.rootPath.isEmpty
                      ? null
                      : () => ExportService.openFolder(downloads.rootPath),
                  icon: const Icon(Icons.folder_open),
                ),
              ),
              ListTile(
                title: const Text('同时下载页数'),
                subtitle: Text('${settings.downloadPages} 页（每话内并发，重新开始时生效）'),
                trailing: DropdownButton<int>(
                  value: settings.downloadPages,
                  underline: const SizedBox.shrink(),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('1')),
                    DropdownMenuItem(value: 2, child: Text('2')),
                    DropdownMenuItem(value: 4, child: Text('4')),
                    DropdownMenuItem(value: 6, child: Text('6')),
                    DropdownMenuItem(value: 8, child: Text('8')),
                  ],
                  onChanged: (value) {
                    if (value != null) context.read<Settings>().setDownloadPages(value);
                  },
                ),
              ),
              const Divider(height: 1),
              const _SectionTitle('外观'),
              ListTile(
                leading: const Icon(Icons.palette_outlined),
                title: const Text('主题'),
                subtitle: Text(
                  '${appThemeById(settings.themeId).name} · '
                  '${kThemeModeLabels[settings.themeMode]}',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ThemePage()),
                ),
              ),
              const Divider(height: 1),
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

  /// Lets the user move the library. There is no file picker (it would need a
  /// plugin), so the path is typed; an unusable path falls back to the default
  /// instead of silently failing every download.
  Future<void> _editDownloadRoot(BuildContext context) async {
    final settings = context.read<Settings>();
    final downloads = context.read<DownloadManager>();
    final controller = TextEditingController(text: settings.downloadRoot);
    final value = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('下载保存位置'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: downloads.rootPath.isEmpty ? r'D:\comics' : '留空恢复默认',
            helperText: Platform.isAndroid
                ? 'Android 受系统限制只能存在应用私有目录，留空即可'
                : '填写完整文件夹路径，例如 D:\\comics',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(controller.text),
            child: const Text('保存'),
          ),
        ],
      ),
    );
    controller.dispose();
    if (value == null || !context.mounted) return;
    settings.setDownloadRoot(value);
    await downloads.reload();
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(
          downloads.rootPath.isEmpty
              ? '没有可写目录，下载功能暂时不可用'
              : '下载目录：${downloads.rootPath}',
        ),
      ));
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
