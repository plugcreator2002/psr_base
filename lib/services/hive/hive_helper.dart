import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:psr_base/index.dart';
import 'package:psr_base/services/hive/models/index.dart';
import 'package:psr_base/utils/manage_permission.dart';

/// for building database -> flutter packages pub run build_runner build
class HiveHelper {
  static Future<void> initializes<T>(List<HiveSyncAdapter> models) async {
    final hasPermission = await ManagePermission.request(
      permission: Permission.manageExternalStorage,
    );
    if (!hasPermission) return;

    final dir = await getApplicationDocumentsDirectory();
    Directory directory = Directory(join(dir.path, "db"));

    Hive.init(directory.path);

    for (final element in models) {
      Hive.registerAdapter(element.adapter);

      open(element.name);
    }
  }

  static void close(String name) async {
    Hive.close();
  }

  static void open(String name) async {
    final dir = await getApplicationDocumentsDirectory();

    Directory directory = Directory(join(dir.path, "db"));
    if (!Hive.isBoxOpen(name)) {
      await Hive.openBox(
        name,
        path: join(directory.path, name),
      );
    }
  }
}
