import 'package:flutter/widgets.dart';

/// space vertical in between widgets
Widget intermediate([final double mediate = 2]) {
  return SizedBox(height: mediate);
}

/// space horizontal in between widgets
Widget limitWidth([final double mediate = 2]) {
  return SizedBox(width: mediate);
}
