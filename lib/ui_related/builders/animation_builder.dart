import "package:flutter/material.dart";

class AnimationBuilder<T, C> extends AnimatedWidget {
  /// Animation value
  final Animation<T> animation;

  /// child widget to prevent constant widgets rebuild for no reason
  @Deprecated('use data instead this will be removed on 2022 first patch')
  final C? child;

  /// Data passing to the child can be any type
  ///
  /// * Data will not update after construction phase
  final C? data;

  /// Build Child widget with params of
  ///
  /// * [BuildContext] context
  ///
  /// * [T] value of animation
  ///
  /// * [Widget] child given in parametrs to avoid performance issue
  final Widget Function(BuildContext, T, C?) builder;

  /// Alternative of animation builder
  const AnimationBuilder({
    Key? key,
    required this.animation,
    required this.builder,
    C? data,
    this.child,
  })  : data = data ?? child,
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, animation.value, data);
  }
}
