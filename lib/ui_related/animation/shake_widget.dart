import "package:flutter/material.dart";
import 'package:psr_base/controllers/index.dart' show ShakeController;
import 'package:psr_base/index.dart' show AnimationBuilder, SafeState;

/// * Define only [ShakeWidget] as the parent of your widget
class ShakeWidget extends StatefulWidget {
  final String? id;
  final Duration duration;
  final double deltaX;
  final Widget child;
  final Curve curve;
  final ShakeController? controller;

  const ShakeWidget({
    Key? key,
    this.controller,
    this.duration = const Duration(milliseconds: 500),
    this.deltaX = 20,
    this.curve = Curves.bounceOut,
    required this.child,
    required this.id,
  }) : super(key: key);

  @override
  SafeState<ShakeWidget> createState() => _S();
}

class _S extends SafeState<ShakeWidget> with SingleTickerProviderStateMixin {
  double maxShake = 0;
  late final Animation<double> _animation;
  late final AnimationController _animationControl;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null && widget.id != null) {
      _animationControl = AnimationController(
        vsync: this,
        duration: widget.duration,
        lowerBound: 0,
        upperBound: 1,
      );
      _animation = Tween<double>(begin: 0, end: 1).animate(_animationControl);

      widget.controller?.addListener(widget.id ?? "", () {
        if (mounted) {
          setState(() {
            _animationControl.forward(from: 0.0);
          });
        }
      });
    }
  }

  double shake(double animation) {
    return 0.5 * (0.5 - (0.5 - widget.curve.transform(animation)).abs());
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller == null || widget.id == null) return widget.child;
    return AnimationBuilder<double, Widget>(
      key: widget.key,
      animation: _animation,
      builder: (context, animation, child) => Transform.translate(
        offset: Offset(widget.deltaX * shake(animation), 0),
        child: child,
      ),
      child: widget.child,
    );
  }
}
