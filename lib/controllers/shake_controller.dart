import 'package:flutter/material.dart';
import 'package:psr_base/index.dart' show FormBuilderState;

class ShakeController {
  final Map<String, void Function()> _listeners = {};

  void addListener(String id, void Function() listener) {
    _listeners.addAll({id: listener});
  }

  void callListener(String id) {
    (_listeners[id] ?? () {})();
  }

  void removeListener(String id) {
    _listeners.remove(id);
  }

  void callAllListeners() {
    for (final listener in _listeners.entries) {
      listener.value();
    }
  }

  Future<bool> validateShaker(GlobalKey<FormBuilderState> key) {
    bool isValid = key.currentState?.validate() ?? false;
    if (!isValid) {
      for (final item in key.currentState!.fields.entries) {
        final isValid = key.currentState!.fields[item.key]?.isValid;
        if (isValid != null && !isValid) {
          callListener(item.key);
        }
      }
    }

    return Future.value(isValid);
  }
}
