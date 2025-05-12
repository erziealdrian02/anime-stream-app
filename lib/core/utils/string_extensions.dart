extension StringExtensions on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get firstLetter {
    if (isEmpty) return '';
    return this[0].toUpperCase();
  }

  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }

  bool containsIgnoreCase(String query) {
    return toLowerCase().contains(query.toLowerCase());
  }

  String removeHtmlTags() {
    return replaceAll(RegExp(r'<[^>]*>'), '');
  }
}
