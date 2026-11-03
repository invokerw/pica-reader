import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/api_client.dart';
import '../api/models.dart';
import '../state/settings.dart';
import 'comic_page.dart';
import 'widgets/comic_card.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({super.key});

  @override
  State<BrowsePage> createState() => _BrowsePageState();
}

class _BrowsePageState extends State<BrowsePage> with AutomaticKeepAliveClientMixin {
  final ScrollController _scroll = ScrollController();
  final List<Comic> _items = [];
  List<Category> _categories = const [];
  String? _category;
  String _sort = 'dd';
  int _page = 0;
  int _total = 0;
  bool _loading = false;
  bool _hasMore = true;
  String? _error;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(() {
      if (_scroll.position.extentAfter < 600) _loadMore();
    });
    _sort = context.read<Settings>().sort;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategories();
      _reload();
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await context.read<ApiClient>().categories();
      if (!mounted) return;
      setState(() => _categories = categories);
    } on ApiException {
      // The grid shows its own error state; category chips are optional.
    }
  }

  Future<void> _reload() async {
    setState(() {
      _items.clear();
      _page = 0;
      _total = 0;
      _hasMore = true;
      _error = null;
    });
    await _loadMore();
  }

  Future<void> _loadMore() async {
    if (_loading || !_hasMore) return;
    setState(() => _loading = true);
    try {
      final paged = await context.read<ApiClient>().comics(
            page: _page + 1,
            sort: _sort,
            category: _category,
          );
      if (!mounted) return;
      setState(() {
        _page = paged.page == 0 ? _page + 1 : paged.page;
        _total = paged.total;
        _items.addAll(paged.docs);
        _hasMore = paged.docs.isNotEmpty && (_total == 0 || _items.length < _total);
        _error = null;
      });
    } on ApiException catch (error) {
      if (!mounted) return;
      setState(() {
        _error = error.message;
        _hasMore = false;
      });
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _selectCategory(String? category) {
    if (_category == category) return;
    setState(() => _category = category);
    _reload();
    if (_scroll.hasClients) _scroll.jumpTo(0);
  }

  void _selectSort(String sort) {
    if (_sort == sort) return;
    setState(() => _sort = sort);
    context.read<Settings>().setSort(sort);
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final settings = context.watch<Settings>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('哔咔阅读器'),
        actions: [
          IconButton(
            tooltip: '刷新',
            onPressed: _reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _reload,
        child: CustomScrollView(
          controller: _scroll,
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _sort,
                          isDense: true,
                          items: [
                            for (final entry in kSortLabels.entries)
                              DropdownMenuItem(value: entry.key, child: Text(entry.value)),
                          ],
                          onChanged: (value) {
                            if (value != null) _selectSort(value);
                          },
                        ),
                      ),
                    ),
                    Text(
                      _total > 0 ? '共 $_total 本' : '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _chip('全部', _category == null, () => _selectCategory(null)),
                    for (final category in _categories)
                      _chip(
                        category.title,
                        _category == category.title,
                        () => _selectCategory(category.title),
                      ),
                  ],
                ),
              ),
            ),
            if (_error != null && _items.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: ErrorRetry(message: _error!, onRetry: _reload),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  gridDelegate: settings.columns > 0
                      ? SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: settings.columns,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.58,
                        )
                      : const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 190,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 0.58,
                        ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: _items.length,
                    (context, index) {
                      final comic = _items[index];
                      return ComicCard(
                        comic: comic,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => ComicDetailPage(comic: comic)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: _loading
                      ? const SizedBox(
                          width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2))
                      : Text(
                          _hasMore || _items.isEmpty ? '' : '没有更多了',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, bool selected, VoidCallback onTap) {
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onSelected: (_) => onTap(),
    );
  }
}
