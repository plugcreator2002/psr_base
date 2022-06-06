import "package:flutter/cupertino.dart";
import 'package:responsive_builder/responsive_builder.dart';

class SizingInformation {
  final Orientation? orientation;
  final DeviceScreenType? deviceScreenType;
  final Size? screenSize;
  final Size? localWidgetSize;

  const SizingInformation({
    this.orientation,
    this.deviceScreenType,
    this.screenSize,
    this.localWidgetSize,
  });

  @override
  String toString() {
    return "Orientation: $orientation > DeviceScreenType: $deviceScreenType > ScreenSize: $screenSize > LocalWidgetSize: $localWidgetSize";
  }
}
