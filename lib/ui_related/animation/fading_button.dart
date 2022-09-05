import 'package:flutter/material.dart';
import 'package:psr_base/ui_related/builders/safe_state.dart';
import 'package:psr_base/utils/operations_related/handle_nullable.dart';

class FadingButton extends StatefulWidget {
  final Widget child;
  final void Function()? onLongPressEnd;

  const FadingButton({
    Key? key,
    required this.child,
    this.onLongPressEnd,
  }) : super(key: key);

  @override
  SafeState<FadingButton> createState() => _FadingButtonState();
}

class _FadingButtonState extends SafeState<FadingButton> {
  double pressing = 1;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: pressing,
      duration: const Duration(milliseconds: 150),
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
