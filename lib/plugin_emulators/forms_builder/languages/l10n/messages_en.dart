import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "en";

  static m1(max) => "Value must be less than or equal to $max";

  static m2(maxLength) {
    return "Value must have a length less than or equal to $maxLength";
  }

  static m3(min) => "Value must be greater than or equal to $min.";

  static m4(minLength) =>
      "Value must have a length greater than or equal to $minLength";

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "This field requires a valid credit card number.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "This field requires a valid date string.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "This field requires a valid email address.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "This field requires a valid IP.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "Value does not match pattern.",
      ),
      "maxErrorText": m1,
      "maxLengthErrorText": m2,
      "minErrorText": m3,
      "minLengthErrorText": m4,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "Value must be numeric.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "This field cannot be empty.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "This field requires a valid URL address.",
      )
    };
  }
}
