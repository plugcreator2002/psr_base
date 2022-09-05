// ignore_for_file: deprecated_member_use

import "package:flutter/material.dart";
import 'package:psr_base/ui_related/animation/fading_button.dart';

class ButtonModules extends StatelessWidget {
  final IconData? icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  final Future<bool>? future;
  final double? fontSize;
  final double? height;
  final double? width;

  final Color? bgColor;
  final Color? borderColor;
  final Color? labelColor;
  final double? iconSize;
  final double? headSize;
  final BorderRadiusGeometry? borderRadius;

  const ButtonModules({
    Key? key,
    this.icon,
    required this.label,
    this.color = Colors.white,
    required this.onTap,
    this.future,
    this.fontSize,
    this.height,
    this.width,
    this.bgColor,
    this.borderColor,
    this.labelColor,
    this.iconSize,
    this.headSize,
    this.borderRadius,
  }) : super(key: key);

  Widget? get _icon {
    if (icon != null) {
      return Icon(
        icon,
        size: 22,
        color: Colors.white,
      );
    }
    return null;
  }

  Widget? _loading(bool isLoading) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.only(left: 8),
        child: SizedBox(
          width: 11,
          height: 11,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        ),
      );
    }
    return null;
  }

  void _onPressed(final bool data) {
    if (data != true) {
      onTap();
    }
  }

  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: future,
      builder: (context, snapshot) {
        return FadingButton(
          onLongPressEnd: () => _onPressed(snapshot.data ?? false),
          child: Container(
            height: (height ?? 33).toDouble(),
            width: width?.toDouble(),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 8,
            ),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(7),
              border: Border.all(
                width: 1,
                color: borderColor ?? bgColor ?? Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                _icon,
                Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: fontSize ?? 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                _loading(snapshot.data ?? false),
              ].whereType<Widget>().toList(),
            ),
          ),
        );
      },
    );
  }
}
