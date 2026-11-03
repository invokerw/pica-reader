import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/models.dart';
import 'comic_page.dart';
import 'widgets/comic_card.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> with AutomaticKeepAliveClientMixin {
  static const _timeframes = {'H24': '日榜', 'D7': '周榜', 'D30': '月榜'};
  String _timeframe = 'H24';
  List<Comic> _items = const [];
  bool _loading = false;
  String? _error;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final paged = await context.read<ApiClient>().leaderboard(timeframe: _timeframe);
      if (!mounted) return;
      setState(() => _items = paged.docs);
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('排行榜'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SegmentedButton<String>(
              segments: [
                for (final entry in _timeframes.entries)
                  ButtonSegment(value: entry.key, label: Text(entry.value)),
              ],
              selected: {_timeframe},
              onSelectionChanged: (value) {
                setState(() => _timeframe = value.first);
                _load();
              },
            ),
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (_loading && _items.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (_error != null && _items.isEmpty) {
            return ErrorRetry(message: _error!, onRetry: _load);
          }
          if (_items.isEmpty) {
            return const EmptyState(message: '榜单暂时为空');
          }
          return RefreshIndicator(
            onRefresh: _load,
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (_, __) => const Divider(height: 1, indent: 16, endIndent: 16),
              itemBuilder: (context, index) {
                final comic = _items[index];
                return ComicTile(
                  comic: comic,
                  rank: index + 1,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ComicPage(comic: comic)),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
