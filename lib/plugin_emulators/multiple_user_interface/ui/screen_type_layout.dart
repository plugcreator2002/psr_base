import 'package:flutter/material.dart';
import 'package:psr_base/index.dart' show Device;
import 'package:responsive_builder/responsive_builder.dart';

class ScreenTypeLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ScreenTypeLayout({
    Key? key,
    required this.mobile,
    this.tablet,
    this.desktop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, information) {
      final deviceType = information.deviceScreenType;

      /// If sizing indicates Tablet and we have a tablet widget then return
      if (deviceType == DeviceScreenType.tablet || Device.get().isTablet) {
        return tablet ?? mobile;
      }

      /// If sizing indicates desktop and we have a desktop widget then return
      if (deviceType == DeviceScreenType.desktop) {
        return desktop ?? mobile;
      }

      /// Return mobile layout if nothing else is supplied
      return mobile;
    });
  }
}
