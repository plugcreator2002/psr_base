import "package:flutter/services.dart";

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length == 1 && newValue.text == "0") {
        return oldValue;
      }

      return newValue;
    } else {
      return newValue;
    }
  }
}
