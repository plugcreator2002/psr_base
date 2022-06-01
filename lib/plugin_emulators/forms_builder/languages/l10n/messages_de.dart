import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "de";

  static m0(value) => "Dieser Feldwert muss $value gleich sein.";

  static m1(max) => "Der Wert muss kleiner als oder gleich $max sein.";

  static m2(maxLength) {
    return "Der Wert muss eine Länge kleiner als oder gleich $maxLength haben.";
  }

  static m3(min) => "Der Wert muss größer als oder gleich $min sein.";

  static m4(minLength) {
    return "Der Wert muss eine Länge größer als oder gleich $minLength haben.";
  }

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "Für dieses Feld ist eine gültige Kreditkartennummer erforderlich.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "Dieses Feld erfordert ein gültiges Datum.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "Für dieses Feld ist eine gültige E-Mail-Adresse erforderlich.",
      ),
      "equalErrorText": m0,
      "integerErrorText": MessageLookupByLibrary.simpleMessage(
        "Der Wert muss eine integer sein.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "Dieses Feld erfordert eine gültige IP-Adresse.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "Der Wert stimmt nicht mit dem Muster überein.",
      ),
      "maxErrorText": m1,
      "maxLengthErrorText": m2,
      "minErrorText": m3,
      "minLengthErrorText": m4,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "Der Wert muss numerisch sein.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "Dieses Feld kann nicht leer sein.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "Für dieses Feld ist eine gültige URL-Adresse erforderlich.",
      )
    };
  }
}
