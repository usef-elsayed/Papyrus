List<String> parseHtmlInIsolate(String html) {
  final RegExp splitPattern = RegExp(
      r"(</p>|</div>|</blockquote>|</h1>|</h2>|</h3>|</h4>|</h5>|</h6>|<hr\s*/?>|<br\s*/?>)",
      caseSensitive: false
  );

  List<String> rawChunks = html.splitMapJoin(
      splitPattern,
      onMatch: (m) => "${m.group(0)}|||SPLIT|||",
      onNonMatch: (n) => n
  ).split("|||SPLIT|||");

  return rawChunks.where((s) {
    final trimmed = s.trim();
    return trimmed.isNotEmpty && trimmed != "<br>" && trimmed != "<br/>";
  }).toList();
}