import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class OpeningPopups {
  static Future<T?> centerPopup<T>(final BuildContext context, {
    final Widget? child,
    final Widget? desktop,
    final Widget? mobile,
    final Widget? tablet,
    final bool dismissible = true,
  }) {
    final output = showCupertinoDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Center(
                child: Material(
                  borderRadius: BorderRadius.circular(11),
                  child: child,
                ),
              ),
            );
          },
        );
      },
    );

    return output;
  }

  static Future<T?> showBottomPopup<T>(final BuildContext context, {
    required final Widget view,
  }) async {
    FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');

    final data = await showSlidingBottomSheet<T>(
      context,
      builder: (context) {
        return SlidingSheetDialog(
          duration: const Duration(milliseconds: 250),
          elevation: 20,
          cornerRadius: 10,
          snapSpec: const SnapSpec(
            initialSnap: 1.0,
            snappings: [1.0, 0.0],
            positioning: SnapPositioning.relativeToSheetHeight,
          ),
          builder: (context, state) {
            return Material(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: view,
              ),
            );
          },
        );
      },
    );

    return data;
  }

  static void showToast(BuildContext context,
      String message, {
        SnackBarAction? snackBarAction,
        EdgeInsetsGeometry? margin,
        Color? backgroundColor,
        Color? contentColor,
        Duration duration = const Duration(milliseconds: 4000),
      }) {
    final theme = Theme.of(context);
    const defualtMargin = EdgeInsets.symmetric(horizontal: 322, vertical: 20);

    ScaffoldMessenger.of(
        context
    ).showSnackBar(SnackBar(
      duration: duration,
      backgroundColor: backgroundColor,
      margin: margin ?? defualtMargin,
      behavior: SnackBarBehavior.floating,
      action: snackBarAction,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyText2?.copyWith(
          fontSize: 12,
          color: contentColor,
        ),
      ),
    ));
  }
}
