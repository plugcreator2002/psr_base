import 'package:device_info_plus/device_info_plus.dart';
import "package:permission_handler/permission_handler.dart";

// use this class when u need access any premotion
class ManagePermission {
  static Future<bool> request({
    final bool openSetting = true,
    final Permission? permission,
  }) async {
    final info = await DeviceInfoPlugin().androidInfo;
    if (info.version.release == null) return false;
    final release = int.parse(info.version.release?.split(".")[0] ?? "");
    Permission hasPermission = permission ?? Permission.storage;
    if (permission == null && openSetting && release > 10) {
      hasPermission = Permission.manageExternalStorage;
    }
    if (await hasPermission.isGranted) {
      return true;
    } else {
      final result = await hasPermission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
