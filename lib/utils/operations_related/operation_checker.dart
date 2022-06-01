bool isMultipleTrue(List<bool> conditions) {
  final checker = conditions.firstWhere((element) {
    return element == false;
  }, orElse: () => true);

  return checker;
}

bool isTrue(bool? data) {
  assert(data != null, false);

  return data ?? false;
}
