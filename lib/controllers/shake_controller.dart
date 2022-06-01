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
}
