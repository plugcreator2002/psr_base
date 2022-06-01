import 'package:flutter/cupertino.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DeviceType {
  static DeviceScreenType getDeviceType(MediaQueryData mediaQuery) {
    final orientation = mediaQuery.orientation;

    double deviceWidth = 0;

    if (orientation == Orientation.landscape) {
      deviceWidth = mediaQuery.size.height;
    } else {
      deviceWidth = mediaQuery.size.width;
    }

    if (deviceWidth > 950) {
      return DeviceScreenType.desktop;
    }

    if (deviceWidth > 600) {
      return DeviceScreenType.tablet;
    }

    return DeviceScreenType.mobile;
  }
}
