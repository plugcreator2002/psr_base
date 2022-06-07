import 'package:flutter/cupertino.dart';

/// When we want just convert data to dart and not have function in class
class SingleSelectionModel<T> {
  final T code;
  final String label;
  final IconData? icon;

  const SingleSelectionModel({
    required this.code,
    required this.label,
    this.icon,
  });
}
