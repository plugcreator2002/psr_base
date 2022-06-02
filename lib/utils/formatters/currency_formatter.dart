import "dart:math";

import "package:flutter/services.dart";
import "package:intl/intl.dart";

class CurrencyFormatter extends TextInputFormatter {
  /// Builds an CurrencyFormatter with the following parameters.
  ///
  /// [locale] argument is used to locale of NumberFormat currency.
  ///
  /// [name] argument is used to locale of NumberFormat currency.
  ///
  /// [symbol] argument is used to symbol of NumberFormat currency.
  ///
  /// [decimalDigits] argument is used to decimalDigits of NumberFormat currency.
  ///
  /// [customPattern] argument is used to locale of NumberFormat currency.
  ///
  /// [turnOffGrouping] argument is used to locale of NumberFormat currency.
  CurrencyFormatter({
    this.locale,
    this.maxLength,
    this.name,
    this.symbol,
    this.decimalDigits,
    this.customPattern,
    this.turnOffGrouping = false,
  });

  /// Defaults `locale` is null.
  ///
  /// Put "en" or "es" for locale
  final String? locale;

  /// Defaults `name` is null.
  ///
  /// the currency with that ISO 4217 name will be used.
  /// Otherwise we will use the default currency name for the current locale.
  /// If no [symbol] is specified, we will use the currency name in the formatted result.
  /// e.g. var f = NumberFormat.currency(locale: "en_US", name: "EUR") will format currency like "EUR1.23".
  /// If we did not specify the name, it would format like "USD1.23".
  final String? name;

  final int? maxLength;

  /// Defaults `symbol` is null.
  ///
  /// Put "\$" for symbol
  final String? symbol;

  /// Defaults `decimalDigits` is null.
  final int? decimalDigits;

  /// Defaults `customPattern` is null.
  ///
  /// Can be used to specify a particular format.
  /// This is useful if you have your own locale data which includes unsupported formats
  /// (e.g. accounting format for currencies.)
  final String? customPattern;

  /// Defaults `turnOffGrouping` is false.
  ///
  /// Explicitly turn off any grouping (e.g. by thousands) in this format.
  /// This is used in compact number formatting, where we omit the normal grouping.
  /// Best to know what you"re doing if you call it.
  final bool turnOffGrouping;

  num _newNum = 0;
  String _newString = "";

  void _formatter(String newText, bool isNegative) {
    final NumberFormat format = NumberFormat.currency(
      locale: locale,
      name: name,
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: customPattern,
    );
    if (turnOffGrouping) {
      format.turnOffGrouping();
    }

    _newNum = num.tryParse(newText) ?? 0;
    if (format.decimalDigits! > 0) {
      _newNum /= pow(10, format.decimalDigits!);
    }

    String output = _newNum.toString();

    if (maxLength != null && output.length > maxLength!) {
      output = output.substring(0, maxLength);
    }

    _newString =
        (isNegative ? "-" : "") + format.format(int.parse(output)).trim();
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final oldLength = oldValue.text.length;
    final newLength = newValue.text.length;
    final isRemovedCharacter = [
      (oldLength - 1) == newLength && oldValue.text.startsWith(newValue.text)
    ][0];

    final bool isNegative = newValue.text.startsWith("-");
    String newText = newValue.text.replaceAll(RegExp("[^0-9]"), "");

    // If the user wants to remove a digit, but the last character of the
    // formatted text is not a digit (for example, "1,00 €"), we need to remove
    // the digit manually.
    if (isRemovedCharacter && !_lastCharacterIsDigit(oldValue.text)) {
      final int length = newText.length - 1;
      newText = newText.substring(0, length > 0 ? length : 0);
    }

    _formatter(newText, isNegative);

    if (newText.trim() == "") {
      return newValue.copyWith(
        text: isNegative ? "-" : "",
        selection: TextSelection.collapsed(offset: isNegative ? 1 : 0),
      );
    } else if (newText == "00" || newText == "000") {
      return TextEditingValue(
        text: isNegative ? "-" : "",
        selection: TextSelection.collapsed(offset: isNegative ? 1 : 0),
      );
    }

    return TextEditingValue(
      text: _newString,
      selection: TextSelection.collapsed(offset: _newString.length),
    );
  }

  static bool _lastCharacterIsDigit(String text) {
    final String lastChar = text.substring(text.length - 1);
    return RegExp("[0-9]").hasMatch(lastChar);
  }

  /// Get String type value with format such as `$ 2,000.00`
  String getFormattedValue() {
    return _newString;
  }

  /// Get num type value without format such as `2000.00`
  num getUnformattedValue() {
    return _newNum;
  }

  /// Method for formatting value.
  /// You can use initialValue with this method.
  String format(String value) {
    final bool isNegative = value.startsWith("-");
    final String newText = value.replaceAll(RegExp("[^0-9]"), "");
    _formatter(newText, isNegative);
    return _newString;
  }
}
