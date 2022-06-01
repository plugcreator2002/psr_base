import "package:flutter/material.dart";

class FieldsConditions extends StatelessWidget {
  final List<bool?> conditions;
  final List<bool>? subcategories;
  final Widget? child;
  final Widget? orChild;

  const FieldsConditions({
    final Key? key,
    required this.conditions,
    this.subcategories,
    this.child,
    this.orChild,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isQuestion = conditions.firstWhere((element) {
      return element == false;
    }, orElse: () => true);

    if (isQuestion != null) {
      if (isQuestion) {
        return child ?? const SizedBox();
      }
      return orChild ?? const SizedBox();
    }
    return const SizedBox();
  }
}
