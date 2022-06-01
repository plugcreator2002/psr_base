import "dart:async";
import "dart:io";
import "package:path/path.dart" show basename, join;
import "dart:io" as io;
import 'package:psr_base/index.dart' show DirectoriesModel, ManagePermission;
import "package:path_provider/path_provider.dart" as provider;

class BackupModel {
  static String get formatted {
    final now = DateTime.now();
    final date = "${now.year}-${now.month}-${now.day}";
    final time = DateTime.now().toString().split(".")[0].split(" ")[1];
    return "$date ${time.replaceAll(":", "-")}";
  }

  static Future<bool> copyDirectory(
    final io.Directory source,
    final io.Directory destination,
  ) async {
    bool output = false;
    source.listSync(recursive: true).forEach((entity) async {
      try {
        if (entity is io.Directory) {
          final newDirectory = io.Directory(join(
            destination.absolute.path,
            basename(entity.path),
          ));
          newDirectory.createSync(recursive: true);

          await copyDirectory(
            entity.absolute,
            newDirectory,
          ).onError((error, stackTrace) {
            output = false;
            return Future.error(false);
          });
        } else if (entity is io.File) {
          entity.copySync(join(
            destination.path,
            basename(entity.path),
          ));
        }
      } catch (err) {
        output = false;
        if (err is FileSystemException) {
          if (err.path != null && !File(err.path ?? "").existsSync()) {
            return Future.error(false);
          }
        }
        return Future.error(false);
      }
    });
    return output;
  }

  static Future<bool> getBackupFolder() async {
    final dir = await DirectoriesModel.create(folder: "BackUp/$formatted");
    final documents = await provider.getApplicationDocumentsDirectory();
    final directory = io.Directory(join(documents.path, "db"));

    if (dir != null) {
      await copyDirectory(directory, dir).onError((error, stackTrace) {
        return Future.error(false);
      });
    }
    return Future.value(true);
  }

  static Future<void> restoreFolder(final String date) async {
    final dir = await DirectoriesModel.create(folder: "BackUp/$date");
    final documents = await provider.getApplicationDocumentsDirectory();
    final directory = io.Directory(join(documents.path, "db"));

    if (dir != null) {
      if (directory.existsSync()) {
        directory.deleteSync(recursive: true);
      }

      copyDirectory(dir, directory);
    }
  }

  static Future<bool> remove(final String date) async {
    if (await ManagePermission.request()) {
      final dir = await DirectoriesModel.create(folder: "BackUp/$date");

      if (dir != null && dir.existsSync()) {
        dir.deleteSync(recursive: true);
        return !dir.existsSync();
      }
    }
    return false;
  }

  static Future<List<io.FileSystemEntity>> backups({
    final bool openSetting = true,
  }) async {
    final dir = await DirectoriesModel.create(
      folder: "BackUp",
      openSetting: openSetting,
    ).onError((error, stackTrace) {
      return null;
    });

    if (dir != null && dir.existsSync()) {
      return io.Directory(
        dir.path,
      ).listSync();
    }
    return [];
  }

  static Future<bool> restoreBackup(
    final String path, {
    final bool openSetting = true,
  }) async {
    if (await ManagePermission.request(openSetting: openSetting)) {
      if (!io.File(path).existsSync()) return false;

      final restored = await io.File(path).delete();

      return !restored.existsSync();
    }
    return false;
  }

  static Future<io.File> moveFile(
    final io.File sourceFile,
    final String newPath, {
    final bool openSetting = true,
  }) async {
    try {
      return await sourceFile.rename(newPath);
    } catch (e) {
      if (await ManagePermission.request(openSetting: openSetting)) {
        final newFile = await sourceFile.copy(newPath);
        return newFile;
      }
      return sourceFile;
    }
  }

  static Future<void> copyFile(
    String name, {
    final bool openSetting = true,
  }) async {
    if (await ManagePermission.request(openSetting: openSetting)) {
      io.Directory? dir = await DirectoriesModel.create();
      final documents = await provider.getApplicationDocumentsDirectory();
      final directory = io.Directory(join(documents.path, "db"));
      final dbFile = io.File(join(directory.path, name, "$name.hive"));

      final base = basename(dbFile.path);
      if (directory.existsSync() && dir != null) {
        await moveFile(dbFile, dir.path + base);
      }
    }
  }
}
