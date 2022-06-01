import 'package:flutter/material.dart';

class DirectionStatus extends StatelessWidget {
  final bool beRower;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  const DirectionStatus({
    Key? key,
    this.beRower = true,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (beRower) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      );
    }
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: children,
    );
  }
}
