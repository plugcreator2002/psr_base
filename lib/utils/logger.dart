import 'dart:developer';

void logger(message, [bool active = true]) {
  if (active) {
    log(message.toString());
  }
}
