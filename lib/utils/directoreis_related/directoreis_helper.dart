import "dart:async";
import "dart:io";

import 'package:package_info_plus/package_info_plus.dart' show PackageInfo;
import 'package:path/path.dart' show basename;
import 'package:path_provider/path_provider.dart'
    show getExternalStorageDirectory;
import 'package:psr_base/utils/manage_permission.dart';

class DirectoriesModel {
  static Future<Directory?> create({
    final String folder = "BackUp",
    final bool openSetting = true,
  }) async {
    try {
      PackageInfo info = await PackageInfo.fromPlatform();
      if (await ManagePermission.request(openSetting: openSetting)) {
        Directory? dir = await getExternalStorageDirectory();
        if (dir != null) {
          final path = dir.path.split("/");
          final endPath = path.sublist(0, dir.path.split("/").length - 4);

          dir = Directory("${endPath.join("/")}/${info.appName}/$folder/");

          if (dir.existsSync() == false) {
            return dir.create(recursive: true);
          }
        }
        return dir;
      } else {
        return Future.error(false);
      }
    } on Exception {
      return Future.error(false);
    }
  }

  static Future<File?> copiesFile(
    final File file,
    final String folder, {
    final bool openSetting = true,
  }) async {
    if (await ManagePermission.request(openSetting: openSetting)) {
      Directory? dir = await create(folder: folder);

      final base = basename(file.path);

      if (file.existsSync() && dir != null) {
        final moved = await file.copy(dir.path + base);
        return moved;
      }
    }
    return null;
  }
}
