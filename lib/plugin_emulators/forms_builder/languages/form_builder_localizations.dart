import "dart:async";

import "package:intl/intl.dart";
import "package:flutter/material.dart";
import 'package:psr_base/plugin_emulators/forms_builder/languages/l10n/messages_all.dart';

class FormLocalizations {
  static Future<FormLocalizations> load(Locale locale) {
    String name;

    if (locale.countryCode?.isEmpty == true) {
      name = locale.languageCode;
    }
    name = locale.toString();

    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return FormLocalizations();
    });
  }

  static const delegate = _LocalizationsDelegate();

  static _localizations(BuildContext context) {
    return Localizations.of<FormLocalizations>(context, FormLocalizations);
  }

  static FormLocalizations of(BuildContext context) {
    if (_localizations(context) != null) {
      return _localizations(context);
    }
    return FormLocalizations();
  }

  String get requiredError {
    return Intl.message(
      "This field cannot be empty.",
      name: "requiredError",
      desc: "Error Text for required validator",
    );
  }

  String equalError<T>(T value) {
    return Intl.message(
      "This field value must be equal to $value.",
      name: "equalError",
      args: [value!],
      desc: "Error Text for equal validator",
    );
  }

  String notEqualError<T>(T value) {
    return Intl.message(
      "This field value must not be equal to $value.",
      name: "notEqualError",
      args: [value!],
      desc: "Error Text for not-equal validator",
    );
  }

  String minError(num min) {
    return Intl.message(
      "Value must be greater than or equal to $min.",
      name: "minError",
      args: [min],
      desc: "Error Text for required field",
    );
  }

  String minLengthError(int minLength) {
    return Intl.message(
      "Value must have a length greater than or equal to $minLength",
      name: "minLength",
      args: [minLength],
      desc: "Error Text for minLength validator",
    );
  }

  String maxErrorText(num max) {
    return Intl.message(
      "Value must be less than or equal to $max",
      name: "maxErrorText",
      args: [max],
      desc: "Error Text for max validator",
    );
  }

  String maxLengthError(int maxLength) {
    return Intl.message(
      "Value must have a length less than or equal to $maxLength",
      name: "maxLengthError",
      args: [maxLength],
      desc: "Error Text for required field",
    );
  }

  String get emailErrorText {
    return Intl.message(
      "This field requires a valid email address.",
      name: "emailErrorText",
      desc: "Error Text for email validator",
    );
  }

  String get urlError {
    return Intl.message(
      "This field requires a valid URL address.",
      name: "urlError",
      desc: "Error Text for URL validator",
    );
  }

  String get matchError {
    return Intl.message(
      "Value does not match pattern.",
      name: "matchError",
      desc: "Error Text for pattern validator",
    );
  }

  String get numericError {
    return Intl.message(
      "Value must be numeric.",
      name: "numericError",
      desc: "Error Text for numeric validator",
    );
  }

  String get integerError {
    return Intl.message(
      "Value must be an integer.",
      name: "integerError",
      desc: "Error Text for integer validator",
    );
  }

  String get creditCardError {
    return Intl.message(
      "کدملی شما اشتباه است",
      name: "creditCardError",
      desc: "Error Text for credit card validator",
    );
  }

  String get ipError {
    return Intl.message(
      "This field requires a valid IP.",
      name: "ipError",
      desc: "Error Text for IP address validator",
    );
  }

  String get dateStringError {
    return Intl.message(
      "This field requires a valid date string.",
      name: "dateStringError",
      desc: "Error Text for date string validator",
    );
  }
}

class _LocalizationsDelegate extends LocalizationsDelegate<FormLocalizations> {
  const _LocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return [
      "de",
      "en",
      "es",
      "fa",
      "fr",
      "hu",
      "it",
      "ja",
      "pt",
      "sk",
      "pl",
      "ar"
    ].contains(locale.languageCode);
  }

  @override
  Future<FormLocalizations> load(Locale locale) {
    return FormLocalizations.load(locale);
  }

  @override
  bool shouldReload(_LocalizationsDelegate old) {
    return false;
  }
}
