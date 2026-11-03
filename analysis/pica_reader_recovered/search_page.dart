import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/models.dart';
import 'comic_page.dart';
import 'widgets/comic_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with AutomaticKeepAliveClientMixin {
  final TextEditingController _input = TextEditingController();
  final List<Comic> _results = [];
  List<String> _keywords = const [];
  String _lastQuery = '';
  bool _loading = false;
  String? _error;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadKeywords());
  }

  @override
  void dispose() {
    _input.dispose();
    super.dispose();
  }

  Future<void> _loadKeywords() async {
    try {
      final keywords = await context.read<ApiClient>().keywords();
      if (!mounted) return;
      setState(() => _keywords = keywords.take(24).toList());
    } on ApiException {
      // Search still works without the suggestion chips.
    }
  }

  Future<void> _search(String keyword) async {
    final query = keyword.trim();
    if (query.isEmpty) return;
    _input.text = query;
    setState(() {
      _loading = true;
      _error = null;
      _lastQuery = query;
    });
    try {
      final paged = await context.read<ApiClient>().advancedSearch(keyword: query);
      if (!mounted) return;
      setState(() => _results
        ..clear()
        ..addAll(paged.docs));
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _surprise() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final paged = await context.read<ApiClient>().random();
      if (!mounted) return;
      setState(() {
        _results
          ..clear()
          ..addAll(paged.docs);
        _lastQuery = '随机推荐';
      });
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
    final narrow = MediaQuery.sizeOf(context).width < 720;
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _input,
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(
            hintText: '搜索漫画、作者',
            border: InputBorder.none,
          ),
          onSubmitted: _search,
        ),
        actions: [
          IconButton(onPressed: () => _search(_input.text), icon: const Icon(Icons.search)),
          IconButton(
            tooltip: '随机推荐',
            onPressed: _surprise,
            icon: const Icon(Icons.casino_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          if (_keywords.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final keyword in _keywords)
                    ActionChip(label: Text(keyword), onPressed: () => _search(keyword)),
                ],
              ),
            ),
          if (_loading) const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          ),
          if (_error != null)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Center(child: Text(_error!)),
            ),
          if (!_loading && _lastQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: Text(
                _results.isEmpty ? '没有找到「$_lastQuery」' : '「$_lastQuery」的结果',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          if (_results.isNotEmpty)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: narrow ? 170 : 190,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.58,
              ),
              itemCount: _results.length,
              itemBuilder: (context, index) {
                final comic = _results[index];
                return ComicCard(
                  comic: comic,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => ComicPage(comic: comic)),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
