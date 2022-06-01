// Single selection model

class SingleSelectionModel<T> {
  final String code, label;
  final T? custom;

  const SingleSelectionModel({
    required this.code,
    required this.label,
    this.custom,
  });
}
