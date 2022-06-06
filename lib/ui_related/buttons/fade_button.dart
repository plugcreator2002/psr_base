import 'package:flutter/material.dart';
import 'package:psr_base/index.dart' show HandleNullable;

/// hold the widget -> the widget will be blurred
///
/// like normal clicking
class FadingButton extends StatefulWidget {
  final Widget child;
  final void Function()? onLongPressEnd;
  const FadingButton({
    Key? key,
    required this.child,
    this.onLongPressEnd,
  }) : super(key: key);

  @override
  State<FadingButton> createState() => _FadingButtonState();
}

class _FadingButtonState extends State<FadingButton> {
  double pressing = 1;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: pressing,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: (_) {
          if (widget.onLongPressEnd.isNotNull) {
            setState(() {
              pressing = 0.4;
            });
          }
        },
        onTapUp: (_) {
          if (widget.onLongPressEnd.isNotNull) {
            setState(() => pressing = 1.0);
            (widget.onLongPressEnd ?? () {})();
          }
        },
        onTapCancel: () {
          if (widget.onLongPressEnd.isNotNull) {
            setState(() {
              pressing = 1.0;
            });
          }
        },
        child: widget.child,
      ),
    );
  }
}
