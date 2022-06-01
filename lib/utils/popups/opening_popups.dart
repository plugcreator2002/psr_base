import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
import 'package:psr_base/index.dart' show CenterPopupsBuilder;

class OpeningPopups {
  static Future<T?> centerPopup<T>(
    final BuildContext context, {
    required final Widget child,
    final void Function()? callback,
    final bool withoutBackground = false,
  }) {
    final output = showDialog<T>(
      context: context,
      builder: (BuildContext context) {
        if (withoutBackground) return child;
        return CenterPopupsBuilder(
          callback: callback ?? () => Navigator.pop(context),
          child: child,
        );
      },
    );

    return output;
  }

  static Future<T?> showBottomPopup<T>(
    final BuildContext context, {
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

  static void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(
          fontFamily: "yekan",
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    ));
  }
}
