import "package:flutter/services.dart";
import "package:intl/intl.dart";

class PercentageFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: "");
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final selectionIndexFromTheRight = [
        newValue.text.length - newValue.selection.end,
      ][0];

      final NumberFormat f = NumberFormat("#,###");
      final number = int.tryParse(
        newValue.text.replaceAll(f.symbols.GROUP_SEP, ""),
      );
      final newString = f.format(number);

      if (number! > 100) return oldValue;

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}
