// ignore_for_file: no_logic_in_create_state
import "package:flutter/material.dart";
import 'package:psr_base/index.dart' show SafeState, StepsController;

/// [T] it's your DataType
class StepsBuilder<T> extends StatefulWidget {
  /// the list of you want use in step by step
  final List<T> items;

  /// [prePage] Specifies how many items your list will display in each step
  final int prePage;

  /// it's your scrolling [physics]
  final ScrollPhysics physics;

  /// it's your widget item of in the list
  final Widget Function(T element, int index) builder;

  /// With [separatorBuilder] you can define between each widget item
  final Widget Function(BuildContext, int) separatorBuilder;

  /// You must create a [StepsController] to switch between the next and previous steps
  final StepsController controller;

  const StepsBuilder({
    Key? key,
    this.items = const [],
    required this.controller,
    required this.builder,
    required this.separatorBuilder,
    this.prePage = 20,
    this.physics = const NeverScrollableScrollPhysics(),
  }) : super(key: key);

  @override
  S<T> createState() => S<T>(items);
}

class S<T> extends SafeState<StepsBuilder<T>> with TickerProviderStateMixin {
  S(this.items);
  late AnimationController _controller;
  late Tween<double> tween;
  late List<T> items;

  int totals = 0;
  int current = 1;

  @override
  void initState() {
    items = widget.items;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      value: 0.5,
      vsync: this,
    );
    tween = Tween<double>(begin: 0.0, end: 1.0);

    totals = (items.length / widget.prePage).round();
    current = 1;

    widget.controller.addListener(nextStep, previousStep);
    super.initState();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextStep() {
    if (current < totals) {
      _controller.forward(from: 0.9).then((value) {
        if (_controller.isCompleted) {
          setState(() {
            current++;
          });
        }
      });
    }
  }

  void previousStep() {
    if (current > 1) {
      _controller.forward(from: 0.9).then((value) {
        if (_controller.isCompleted) {
          setState(() {
            current--;
          });
        }
      });
    }
  }

  double get animate {
    if (_controller.isAnimating == false) return 1;
    return _controller.value;
  }

  @override
  Widget build(BuildContext context) {
    int offset = (current - 1) * widget.prePage;
    int limit = offset + widget.prePage;
    if (limit > items.length) {
      limit = limit - (limit - items.length);
    }
    return ListView.separated(
      separatorBuilder: widget.separatorBuilder,
      shrinkWrap: true,
      physics: widget.physics,
      itemCount: items.sublist(offset, limit).length,
      itemBuilder: (context, index) {
        return widget.builder(
          items.sublist(offset, limit)[index],
          index,
        );
      },
    );
  }
}
