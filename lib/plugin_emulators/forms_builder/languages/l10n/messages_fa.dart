import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "fa";

  static m1(max) => "مقدار باید برابر یا کمتر از $max باشد.";

  static m2(maxLength) {
    return "مقدار باید دارای طول بزرگتر یا برابر $maxLength باشد.";
  }

  static m3(min) => "مقدار باید برابر یا بیشتر از $min باشد.";

  static m4(minLength) =>
      "مقدار باید دارای طول بزرگتر یا برابر {minLength} باشد.";

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "این ورودی به شماره کارت اعتباری معتبر نیاز دارد.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "این ورودی به یک تاریخ معتبر نیاز دارد.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "این ورودی به یک آدرس ایمیل معتبر نیاز دارد.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "این قسمت نیاز به یک IP معتبر دارد.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "مقدار با الگو مطابقت ندارد.",
      ),
      "maxErrorText": m1,
      "maxLengthErrorText": m2,
      "minErrorText": m3,
      "minLengthErrorText": m4,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "مقدار باید عددی باشد.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "این ورودی نمی تواند خالی باشد.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "این ورودی به آدرس اینترنتی معتبر نیاز دارد.",
      ),
    };
  }
}
