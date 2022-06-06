import 'package:flutter/material.dart';

/// is safe [StatefulWidget] when you do setState
abstract class SafeState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
