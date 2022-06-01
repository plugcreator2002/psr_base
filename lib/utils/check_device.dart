import 'dart:io';
import 'dart:ui' as ui;
import 'dart:math' as math;

class Device {
  static double devicePixelRatio = ui.window.devicePixelRatio;
  static ui.Size size = ui.window.physicalSize;
  static double width = size.width;
  static double height = size.height;
  static double screenWidth = width / devicePixelRatio;
  static double screenHeight = height / devicePixelRatio;
  static ui.Size screenSize = ui.Size(screenWidth, screenHeight);
  final bool isTablet, isPhone, isIos, isAndroid, isIphoneX, hasNotch;
  static Device? _device;
  static Function? onMetricsChange;

  const Device({
    required this.isTablet,
    required this.isPhone,
    required this.isIos,
    required this.isAndroid,
    required this.isIphoneX,
    required this.hasNotch,
  });

  factory Device.get() {
    if (_device != null) return _device!;

    if (onMetricsChange == null) {
      onMetricsChange = ui.window.onMetricsChanged;
      ui.window.onMetricsChanged = () {
        _device = null;

        size = ui.window.physicalSize;
        width = size.width;
        height = size.height;
        screenWidth = width / devicePixelRatio;
        screenHeight = height / devicePixelRatio;
        screenSize = ui.Size(screenWidth, screenHeight);

        (onMetricsChange ?? () {})();
      };
    }

    bool isTablet;
    bool isPhone;
    bool isIos = Platform.isIOS;
    bool isAndroid = Platform.isAndroid;
    bool isIphoneX = false;
    bool hasNotch = false;

    double ratio = size.width / size.height;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else if ((ratio >= 0.74) && (ratio < 1.5)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }

    // Recalculate for Android Tablet using device inches
    if (isAndroid) {
      final adjustedWidth = _calWidth() / devicePixelRatio;
      final adjustedHeight = _calHeight() / devicePixelRatio;
      final mathPlus = math.pow(adjustedWidth, 2) + math.pow(adjustedHeight, 2);
      final diagonalSizeInches = (math.sqrt(mathPlus)) / _ppi;

      if (diagonalSizeInches >= 7) {
        isTablet = true;
        isPhone = false;
      } else if ((ratio >= 0.74) && (ratio < 1.5)) {
        isTablet = true;
        isPhone = false;
      } else {
        isTablet = false;
        isPhone = true;
      }
    }

    if (isIos &&
        isPhone &&
        (screenHeight == 812 ||
            screenWidth == 812 ||
            screenHeight == 896 ||
            screenWidth == 896 ||
            screenHeight == 844 ||
            screenWidth == 844 ||
            screenHeight == 926 ||
            screenWidth == 926)) {
      isIphoneX = true;
      hasNotch = true;
    }

    if (_hasTopOrBottomPadding()) hasNotch = true;

    return _device = Device(
      isTablet: isTablet,
      isPhone: isPhone,
      isAndroid: isAndroid,
      isIos: isIos,
      isIphoneX: isIphoneX,
      hasNotch: hasNotch,
    );
  }

  static double _calWidth() {
    if (width > height) {
      final plusUis = ui.window.viewPadding.left + ui.window.viewPadding.right;
      return (width + (plusUis) * width / height);
    }
    return (width + ui.window.viewPadding.left + ui.window.viewPadding.right);
  }

  static double _calHeight() {
    final plusUis = ui.window.viewPadding.top + ui.window.viewPadding.bottom;
    return (height + (plusUis));
  }

  static int get _ppi {
    if (Platform.isAndroid) {
      return 160;
    } else {
      if (Platform.isIOS) {
        return 150;
      }
      return 96;
    }
  }

  static bool _hasTopOrBottomPadding() {
    final padding = ui.window.viewPadding;
    return padding.top > 0 || padding.bottom > 0;
  }
}
