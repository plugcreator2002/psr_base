import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "pl";

  static m0(value) => "Wartość tego pola musi wynosić $value.";

  static m1(max) => "Wartość musi być mniejsza lub równa $max.";

  static m2(maxLength) => "Wartość nie może przekraczać $maxLength znaków.";

  static m3(min) => "Wartość musi być większa lub równa $min.";

  static m4(minLength) {
    return "Wartość musi wynosić co najmniej $minLength znaków.";
  }

  static m5(value) => "Wartość tego pola nie może być $value.";

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);

  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "To pole wymaga podania ważnego numeru karty kredytowej.",
      ),
      "DateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "To pole wymaga poprawnego ciągu znaków daty.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "To pole wymaga podania poprawnego adresu e-mail.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "To pole wymaga ważnego IP.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "Wartość nie pasuje do wzorca.",
      ),
      "maxErrorText": m0,
      "MaxLengthErrorText": m1,
      "minErrorText": m2,
      "MinLengthErrorText": m3,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "Wartość musi być numeryczna.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "To pole nie może być puste.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "To pole wymaga podania poprawnego adresu URL.",
      )
    };
  }
}
