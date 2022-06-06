import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psr_base/index.dart'
    show SafeState, SizingInformation, DeviceType;

class BaseWidgets extends StatefulWidget {
  final Widget Function(
    BuildContext context,
    SizingInformation pageInformation,
  ) builder;

  const BaseWidgets({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  State<BaseWidgets> createState() => _BaseWidgetsState();
}

class _BaseWidgetsState extends SafeState<BaseWidgets> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      child: OrientationBuilder(
        key: widget.key,
        builder: (BuildContext context, Orientation orientation) {
          return LayoutBuilder(builder: (context, constraints) {
            final pageInformation = SizingInformation(
              orientation: orientation,
              deviceScreenType: DeviceType.getDeviceType(mediaQuery),
              screenSize: mediaQuery.size,
              localWidgetSize: Size(
                constraints.maxWidth,
                constraints.maxHeight,
              ),
            );
            return widget.builder(context, pageInformation);
          });
        },
      ),
    );
  }
}
