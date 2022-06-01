import 'dart:convert';

import 'package:psr_base/utils/operations_related/handle_nullable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// you must call init in your main function
class SharedPreferencesHelper {
  static late SharedPreferences instance;

  static Future<void> init() async {
    instance = await SharedPreferences.getInstance();
  }

  static Future<bool> setData(String key, dynamic value) async {
    if (value == null) return false;
    final result = await instance.setString(key, json.encode(value));
    if (result.isNotNull) {
      return result;
    }
    return false;
  }

  static T? readData<T>(final String key) {
    final result = instance.getString(key);
    if (result.isNotNull) {
      return (json.decode(result ?? "")) as T;
    }
    return null;
  }

  static Future<bool> removeData(final String key) async {
    final result = await instance.remove(key);
    if (result.isNotNull) {
      return result;
    }
    return false;
  }
}
