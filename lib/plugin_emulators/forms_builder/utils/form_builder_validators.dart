import "package:flutter/material.dart";
import 'package:psr_base/plugin_emulators/forms_builder/languages/form_builder_localizations.dart';
import 'package:psr_base/utils/extensions/validators.dart';
import 'package:psr_base/utils/operations_related/operation_checker.dart';
import 'package:psr_base/utils/operations_related/operation_converter.dart';

class FormValidators {
  static FormFieldValidator<T> compose<T>(
    List<FormFieldValidator<T>> validators,
  ) {
    return (candidate) {
      for (final validator in validators) {
        final result = validator(candidate);
        if (result != null) {
          return result;
        }
      }
      return null;
    };
  }

  static FormFieldValidator<T> required<T>(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      if (candidate == null) return "";
      final conditions = [
        candidate is String && candidate.trim().isEmpty,
        candidate is Iterable && candidate.isEmpty,
        candidate is Map && candidate.isEmpty,
      ];

      if (conditions[0] || conditions[1] || conditions[2]) {
        return error ?? FormLocalizations.of(context).requiredError;
      }
      return null;
    };
  }

  static FormFieldValidator<T> equal<T>(
    BuildContext context,
    T value, {
    String? error,
  }) {
    return (candidate) {
      String? result;
      if (candidate != value) {
        result = error ?? FormLocalizations.of(context).equalError(value);
      }
      return result;
    };
  }

  static FormFieldValidator<T> notEqual<T>(
    BuildContext context,
    T value, {
    String? error,
  }) {
    return (candidate) {
      String? result;
      if (candidate == value) {
        result = error ?? FormLocalizations.of(context).notEqualError(value);
      }
      return result;
    };
  }

  static FormFieldValidator<T> min<T>(
    BuildContext context,
    num min, {
    bool inclusive = true,
    String? error,
  }) {
    return (candidate) {
      final number = numParser(candidate);
      if (candidate != null) {
        if (number != null && (inclusive ? (number < min) : (number <= min))) {
          return error ?? FormLocalizations.of(context).minError(min);
        }
      }
      return null;
    };
  }

  static FormFieldValidator<T> max<T>(
    BuildContext context,
    num max, {
    bool inclusive = true,
    String? error,
  }) {
    return (T? candidate) {
      final number = numParser(candidate);
      if (candidate != null) {
        if (number != null && (inclusive ? number > max : number >= max)) {
          return error ?? FormLocalizations.of(context).maxErrorText(max);
        }
      }
      return null;
    };
  }

  static FormFieldValidator<String> minLength(
    BuildContext context,
    int minLength, {
    bool allowEmpty = false,
    String? error,
  }) {
    return (candidate) {
      if ((candidate ?? "").isEmpty) return null;
      final length = candidate?.length ?? 0;
      if (length < minLength && (!allowEmpty || length > 0)) {
        return error ?? FormLocalizations.of(context).minLengthError(minLength);
      }

      return null;
    };
  }

  static FormFieldValidator<String> maxLength(
    BuildContext context,
    int maxLength, {
    String? error,
  }) {
    return (candidate) {
      if (candidate != null && candidate.length > maxLength) {
        return error ?? FormLocalizations.of(context).minLengthError(maxLength);
      }

      return null;
    };
  }

  static FormFieldValidator<String> email(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      if (isTrue(candidate?.trim().isEmail)) {
        return null;
      }
      return error ?? FormLocalizations.of(context).emailErrorText;
    };
  }

  static FormFieldValidator<String> url(
    BuildContext context, {
    String? error,
    List<String> protocols = const ["http", "https", "ftp"],
    bool requireTld = true,
    bool requireProtocol = false,
    bool allowUnderscore = false,
    List<String> hostWhitelist = const [],
    List<String> hostBlacklist = const [],
  }) {
    return (candidate) {
      if (isTrue(candidate?.isNotEmpty)) {
        final isUrl = isTrue(candidate?.isURL(
          protocols: protocols,
          requireTld: requireTld,
          requireProtocol: requireProtocol,
          allowUnderscore: allowUnderscore,
          hostWhitelist: hostWhitelist,
          hostBlacklist: hostBlacklist,
        ));
        if (isUrl) {
          return error ?? FormLocalizations.of(context).urlError;
        }
      }
      return null;
    };
  }

  static FormFieldValidator<String> match(
    BuildContext context,
    String pattern, {
    String? error,
  }) {
    return (candidate) {
      if (candidate == null) return null;
      if (isTrue(
        candidate.isNotEmpty && RegExp(pattern).hasMatch(candidate),
      )) {
        return error ?? FormLocalizations.of(context).matchError;
      }
      return null;
    };
  }

  static FormFieldValidator<String> numeric(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      final number = numParser(candidate);
      if (isTrue(candidate?.isNotEmpty) && number == null) {
        return error ?? FormLocalizations.of(context).numericError;
      }
      return null;
    };
  }

  static FormFieldValidator<String> integer(
    BuildContext context, {
    String? error,
    int? radix,
  }) {
    return (candidate) {
      final number = intParser(candidate);
      if (isTrue(candidate?.isNotEmpty) && number == null) {
        return error ?? FormLocalizations.of(context).integerError;
      }
      return null;
    };
  }

  static FormFieldValidator<String> creditCard(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      if (candidate == null || candidate.isEmpty) return "";
      if (!isTrue(candidate.isCreditCard)) {
        return error ?? FormLocalizations.of(context).creditCardError;
      }
      return null;
    };
  }

  static FormFieldValidator<String> isShebaCode(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      if (candidate == null || candidate.isEmpty) return null;
      if (isTrue(candidate.isSheba)) {
        return null;
      }
      return "This not sheba code";
    };
  }

  static FormFieldValidator<String> postalCart(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      if (candidate == null || candidate.isEmpty) return "";
      if (!isTrue(candidate.isPostalCard)) {
        return error ?? FormLocalizations.of(context).creditCardError;
      }
      return null;
    };
  }

  static FormFieldValidator<String> phone(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      if (candidate == null || candidate.isEmpty) return "";
      if (!isTrue(candidate.phone)) {
        return error ?? FormLocalizations.of(context).creditCardError;
      }
      return null;
    };
  }

  static FormFieldValidator<String> landlinePhone(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      if (candidate == null || candidate.isEmpty) return "";
      if (!isTrue(candidate.landlinePhone)) {
        return error ?? FormLocalizations.of(context).creditCardError;
      }
      return null;
    };
  }

  static FormFieldValidator<String> ip(
    BuildContext context, {
    int? version,
    String? error,
  }) {
    return (candidate) {
      if (candidate == null || candidate.isEmpty) return "";
      if (!isTrue(candidate.isIP(version))) {
        return error ?? FormLocalizations.of(context).ipError;
      }
      return null;
    };
  }

  static FormFieldValidator<String> dateString(
    BuildContext context, {
    String? error,
  }) {
    return (candidate) {
      if (isTrue(candidate?.isDate)) {
        return null;
      }
      return error ?? FormLocalizations.of(context).dateStringError;
    };
  }
}
