import 'dart:convert';
import 'dart:developer';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class SocketManager {
  // Socket connection
  IOWebSocketChannel? _socket;
  void Function(String)? onConnect;
  void Function()? onDone;
  void Function(dynamic)? onError;
  void Function(String, dynamic)? onEmit;
  void Function(String)? onReceived;
  String _address = '';

  /// Set address of socket connection
  set address(String value) {
    _address = value;
    _socket = IOWebSocketChannel.connect(
      Uri.parse(value),
    );
    _socket?.stream.timeout(const Duration(hours: 5));
    _revokeAllListeners();
    (onConnect ?? (_) {})(value);
  }

  String get address => _address;

  // Dummy code
  void connect(String value) {
    address = value;
  }

  Future<void> waitForResult(
    String event, {
    Map<String, dynamic> initialData = const {},
    required void Function(String keyReceived, dynamic) callBack,
  }) async {
    _once.addAll({event: callBack});

    await Future.doWhile(() async => _once.containsKey(event));
    return;
  }

  // Sends Data to server through socket connection
  void emit(String key, [dynamic data]) {
    (onEmit ?? (_, __) {})(key, data);
    _socket?.sink.add(json.encode({'event': key, 'data': data}));
  }

  // After changing address all events on socket will be lost it will revoke all of them
  void _revokeAllListeners() {
    _socket?.stream.listen(
      (value) => _eventReceived(value, _socket!),
      onError: (errorMessage) {
        (onError ?? (_) {})(errorMessage);
        connect(address);
      },
      onDone: () {
        (onDone ?? () {})();
        connect(address);
      },
    );
  }

  void _eventReceived(String data, WebSocketChannel sender) {
    (onReceived ?? (_) {})(data);
    try {
      dynamic dataValue = jsonDecode(data);
      String? event = dataValue['event'];
      dynamic value = dataValue['data'];
      if (event != null) {
        _callListenersOn(event, value);
      }
    } catch (e) {
      log("please sync server event with {event: message, data: hello}");
    }
  }

  // Add listener to socket
  void addListener({
    required String event,
    required String key,
    required void Function(String keyReceived, dynamic) listener,
  }) {
    // If event where new it will be added to socket listeners
    if (!_listeners.keys.contains(event)) {
      _listeners.addAll({
        event: {key: listener}
      });
    }

    // If event was not new and listener key where new it will be added to that events listeners
    else if (!_listeners[event]!.keys.contains(key)) {
      _listeners[event]!.addAll({key: listener});
    }

    // If event was not new and listener key existed it will update the listener
    else {
      _listeners[event]![key] = listener;
    }
  }

  // Call listeners of an event
  Future<void> _callListenersOn(String event, dynamic data) async {
    if (_listeners.keys.contains(event)) {
      for (final listener in (_listeners[event] ?? {}).values) {
        listener(event, data);
      }
    }
    if (_once.keys.contains(event)) {
      final listener = _once[event]!;
      _once.remove(event);
      listener(event, data);
    }
  }

  // Remove listener with event and listener key
  bool removeListenerOn(String event, String key) {
    bool result = false;
    if (!_listeners.keys.contains(event)) {
      result = false;
    } else if (_listeners[event]?.keys.contains(key) == false) {
      result = false;
    } else {
      _listeners[event]?.remove(key);
      result = true;
    }
    return result;
  }

  final Map<String, void Function(String, dynamic)> _once = {};
  final Map<String, Map<String, void Function(String, dynamic)>> _listeners = {};

  Map<String, Map<String, void Function(String, dynamic)>> get listeners {
    return _listeners;
  }
}
