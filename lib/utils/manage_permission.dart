import 'package:package_info_plus/package_info_plus.dart';
import "package:permission_handler/permission_handler.dart";

/// use this class when u need access any permission
///
/// control on different versions
class ManagePermission {
  static Future<bool> request({
    final bool openSetting = true,
    final Permission? permission,
  }) async {
    final info = await PackageInfo.fromPlatform();
    final release = int.parse(info.version.split(".")[0]);
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
