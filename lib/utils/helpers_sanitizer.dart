/// Helper functions for validator and sanitizer.

T? shift<T>(List<T> items) {
  if (items.isNotEmpty) {
    final first = items.first;
    items.removeAt(0);
    return first;
  }
  return null;
}

Map merge(Map? object, Map? defaults) {
  object ??= <dynamic, dynamic>{};
  defaults?.forEach((dynamic key, dynamic val) {
    object?.putIfAbsent(key, () {
      return val;
    });
  });
  return object;
}
