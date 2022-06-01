import "package:flutter/material.dart";

class AnimationBuilder<T> extends StatefulWidget {
  final Animation<T> animation;
  final Widget? child;
  final Widget Function(BuildContext, T, Widget?) builder;

  const AnimationBuilder({
    Key? key,
    required this.animation,
    required this.builder,
    this.child,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AnimationBuilderState<T> createState() => _AnimationBuilderState();
}

class _AnimationBuilderState<T> extends State<AnimationBuilder<T>> {
  @override
  void initState() {
    widget.animation.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, widget.animation.value, widget.child);
  }
}
