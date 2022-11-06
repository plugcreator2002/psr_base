import 'package:flutter/cupertino.dart';
import 'package:psr_base/index.dart' show OpeningPopups, SingleSelectionModel;
import 'package:psr_base/ui_related/popups_ui/index.dart';

class PopUpOpeners {
  static Future<T?> listsGenerate<T>(
    final BuildContext context,
    final String title,
    final List<SingleSelectionModel> data,
  ) async {
    final output = await OpeningPopups.showBottomPopup<T>(
      context,
      view: ListsGenerate(
        title: title,
        items: data,
      ),
    );
    return output;
  }

  static Future<T?> question<T>(
    final BuildContext context,
    final String title,
  ) async {
    final result = await OpeningPopups.centerPopup<T>(
      context,
      child: Question(label: title),
    );
    return result;
  }
}
