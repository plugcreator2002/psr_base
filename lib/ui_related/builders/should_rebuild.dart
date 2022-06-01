import "package:flutter/material.dart";

/// you can control the update the const [Widget]
/// You must define a [UniqueKey] for the widget [key]
class ShouldRebuild<T extends Widget> extends StatefulWidget {
  final T child;

  /// Define your bet to update the widget in [shouldRebuild]
  final bool Function(T oldWidget, T newWidget) shouldRebuild;
  final void Function()? onInit;

  const ShouldRebuild({
    Key? key,
    required this.child,
    required this.shouldRebuild,
    this.onInit,
  }) : super(key: key);
  @override
  ShouldRebuildState<T> createState() => ShouldRebuildState<T>();
}

class ShouldRebuildState<T extends Widget> extends State<ShouldRebuild<T>> {
  @override
  ShouldRebuild<T> get widget => super.widget;
  late T oldWidget;

  @override
  void initState() {
    super.initState();
    oldWidget = widget.child;

    if (widget.onInit != null) {
      Future.delayed(const Duration(milliseconds: 1), () {
        (widget.onInit ?? () {})();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final newWidget = widget.child;

    if (widget.shouldRebuild(oldWidget, newWidget)) {
      oldWidget = newWidget;
    }

    return oldWidget;
  }
}
