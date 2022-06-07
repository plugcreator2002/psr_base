import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  final Widget child;
  final bool loading;
  const LoadingPage({
    Key? key,
    required this.child,
    required this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return AbsorbPointer(
        absorbing: loading,
        child: Opacity(
          opacity: 0.5,
          child: child,
        ),
      );
    }
    return child;
  }
}
