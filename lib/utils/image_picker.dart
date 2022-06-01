import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:psr_base/models/local_models.dart';
import 'package:psr_base/utils/directoreis_related/directoreis_helper.dart';
import 'package:psr_base/utils/operations_related/handle_nullable.dart';
import 'package:psr_base/utils/popups/popup_models.dart';

class PictureFromDevice {
  static Future<File?> getImage(
    BuildContext context, [
    ImageSource? source,
    List<SingleSelectionModel>? options,
  ]) async {
    options ??= [
      const SingleSelectionModel<ImageSource>(
        label: "انتخاب از گالری",
        code: ImageSource.gallery,
      ),
      const SingleSelectionModel<ImageSource>(
        label: "دوربین",
        code: ImageSource.camera,
      )
    ];
    if (source.isNull) {
      source = await PopUpOpeners.listsGenerate<ImageSource>(
        context,
        "آپلود عکس کاربری",
        options,
      );
      if (source.isNull) return null;
    }
    final take = await ImagePicker().pickImage(
      imageQuality: 60,
      maxWidth: 800,
      source: source ?? ImageSource.gallery,
    );
    if (take != null) {
      final file = File(take.path);
      final saved = await DirectoriesModel.copiesFile(
        file,
        "images",
      );
      return saved;
    }
    return null;
  }
}
