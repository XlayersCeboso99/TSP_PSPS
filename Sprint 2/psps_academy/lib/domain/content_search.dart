import 'course.dart';

enum MatchField { title, content }

class SearchResult {
  const SearchResult({
    required this.module,
    required this.topic,
    required this.lesson,
    required this.field,
    required this.snippet,
    required this.matchStart,
    required this.matchLength,
  });
  final CourseModule module;
  final Topic topic;
  final Lesson lesson;
  final MatchField field;
  final String snippet;
  final int matchStart;
  final int matchLength;
}

class ContentSearch {
  const ContentSearch(this.modules);
  final List<CourseModule> modules;

  // Explicit implementation choice from the CU-09 mockup: ignore accents,
  // preserve ñ. Each replacement keeps string offsets for highlighting.
  static String normalize(String text) {
    var value = text.toLowerCase();
    const from = 'áéíóúü';
    const to = 'aeiouu';
    for (var i = 0; i < from.length; i++) {
      value = value.replaceAll(from[i], to[i]);
    }
    return value;
  }

  List<SearchResult> search(String query) {
    final term = normalize(query.trim());
    if (term.runes.length < 3) return [];
    final results = <SearchResult>[];
    for (final m in modules) {
      for (final t in m.topics) {
        for (final l in t.lessons) {
          final titles = '${m.title} › ${m.area} › ${t.title} › ${l.title}';
          final content = '${l.content}\n${l.example}';
          final titleMatch = normalize(titles).contains(term);
          final source = titleMatch ? titles : content;
          final at = normalize(source).indexOf(term);
          if (at < 0) continue;
          final start = (at - 30).clamp(0, source.length);
          final end = (at + term.length + 60).clamp(0, source.length);
          final prefix = start > 0 ? '…' : '';
          results.add(
            SearchResult(
              module: m,
              topic: t,
              lesson: l,
              field: titleMatch ? MatchField.title : MatchField.content,
              snippet:
                  '$prefix${source.substring(start, end)}${end < source.length ? '…' : ''}',
              matchStart: at - start + prefix.length,
              matchLength: term.length,
            ),
          );
        }
      }
    }
    // Two stable groups retain catalog order; never include answers or practices.
    return [
      for (final r in results)
        if (r.field == MatchField.title) r,
      for (final r in results)
        if (r.field == MatchField.content) r,
    ];
  }
}
