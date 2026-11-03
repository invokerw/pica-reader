// `ComicInfo.xml`, the metadata file the comic ecosystem understands.
//
// CBZ files are just zips, so a reader can show the pages without any help.
// Media servers (Komga, Kavita) and library managers (Mihon) need more: they
// read `ComicInfo.xml` (ComicInfo 2.0 schema) to group files into a series and
// to name the chapter. Without it a dump of zip files shows up as a pile of
// unrelated books.
//
// Only fields this app can actually fill are written. `<Manga>` (reading
// direction) is deliberately omitted: guessing it wrong is worse than leaving
// it out, because players then force a direction the pages do not follow.

/// Immutable description of one chapter, rendered to `ComicInfo.xml`.
class ComicInfo {
  const ComicInfo({
    required this.series,
    required this.number,
    required this.title,
    this.count = 0,
    this.summary = '',
    this.writer = '',
    this.genres = const [],
    this.pageCount = 0,
    this.languageIso = 'zh',
    this.publisher = 'PicACG',
    this.notes = '',
  });

  /// Comic title, shared by every chapter file of the same comic.
  final String series;

  /// Chapter number (`<Number>`), which is what Komga/Kavita sort on.
  final int number;

  /// Chapter title without the redundant `第 N 话` prefix.
  final String title;

  /// Total number of chapters, `0` when unknown.
  final int count;
  final String summary;
  final String writer;
  final List<String> genres;
  final int pageCount;
  final String languageIso;
  final String publisher;
  final String notes;

  String toXml() {
    final buffer = StringBuffer()
      ..writeln('<?xml version="1.0" encoding="utf-8"?>')
      ..writeln('<ComicInfo xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"'
          ' xmlns:xsd="http://www.w3.org/2001/XMLSchema">');
    void tag(String name, Object? value, {bool skipEmpty = true}) {
      final text = value?.toString() ?? '';
      if (skipEmpty && text.trim().isEmpty) return;
      buffer.writeln('  <$name>${escape(text)}</$name>');
    }

    tag('Title', title.isEmpty ? '第 $number 话' : title);
    tag('Series', series);
    tag('Number', number);
    tag('Count', count > 0 ? count : null);
    tag('Summary', summary);
    tag('Writer', writer);
    tag('Genre', genres.join(', '));
    tag('Publisher', publisher);
    tag('PageCount', pageCount > 0 ? pageCount : null);
    tag('LanguageISO', languageIso);
    tag('Notes', notes);
    buffer.write('</ComicInfo>');
    return buffer.toString();
  }

  /// Escapes text for XML and drops code points XML 1.0 forbids.
  ///
  /// Comic titles and descriptions come from a remote API, so a stray `&` or a
  /// lone surrogate would otherwise produce a file that every reader rejects.
  static String escape(String value) {
    final cleaned = StringBuffer();
    for (final rune in value.runes) {
      final legal = rune == 0x9 ||
          rune == 0xA ||
          rune == 0xD ||
          (rune >= 0x20 && rune <= 0xD7FF) ||
          (rune >= 0xE000 && rune <= 0xFFFD) ||
          (rune >= 0x10000 && rune <= 0x10FFFF);
      if (legal) cleaned.writeCharCode(rune);
    }
    return cleaned
        .toString()
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }
}
