import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "sk";

  static m4(value) => "Hodnota tohto poľa musí byť $value.";

  static m0(max) => "Hodnota musí byť menšia alebo rovná ako $max.";

  static m1(maxLength) => "Hodnota musí mať dĺžku najviac $maxLength znakov.";

  static m2(min) => "Hodnota musí byť väčšia alebo rovná ako $min.";

  static m3(minLength) => "Hodnota musí mať dĺžku aspoň $minLength znakov.";

  static m5(value) => "Hodnota tohto poľa nesmie byť $value.";

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "Toto pole vyžaduje platné číslo platobnej karty.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "Toto pole vyžaduje platný dátum.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "Toto pole vyžaduje platnú emailovú adresu.",
      ),
      "equalErrorText": m4,
      "integerErrorText": MessageLookupByLibrary.simpleMessage(
        "Hodnota musí byť celé číslo.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "Toto pole vyžaduje platnú IP adresu.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "Hodnota nevyhovuje očakávanému tvaru.",
      ),
      "maxErrorText": m0,
      "maxLengthErrorText": m1,
      "minErrorText": m2,
      "minLengthErrorText": m3,
      "notEqualErrorText": m5,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "Hodnota musí byť číslo.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "Toto pole nesmie byť prázdne.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "Toto pole vyžaduje platnú URL adresu.",
      )
    };
  }
}
