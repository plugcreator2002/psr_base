// Single selection model

import 'package:flutter/cupertino.dart';

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
