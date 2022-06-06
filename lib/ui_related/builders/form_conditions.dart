import "package:flutter/material.dart";

/// if you need to show a widget that depends on several conditions -> use this
class FieldsConditions extends StatelessWidget {
  /// your conditions
  final List<bool?> conditions;

  /// if all conditions is true -> [child] is called
  final Widget? child;

  /// if all conditions is not true -> [orChild] is called
  final Widget? orChild;

  const FieldsConditions({
    final Key? key,
    required this.conditions,
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
