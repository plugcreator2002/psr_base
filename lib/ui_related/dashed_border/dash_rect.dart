import 'package:flutter/material.dart';
import 'dash_rect_painter.dart';

class DashedRect extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final double gap;
  final Widget child;

  const DashedRect({
    Key? key,
    this.color = Colors.black,
    this.strokeWidth = 0.8,
    this.gap = 5.0,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(strokeWidth / 3),
      child: CustomPaint(
        painter: DashRectPainter(
          color: color,
          strokeWidth: strokeWidth,
          gap: gap,
        ),
        child: child,
      ),
    );
  }
}
