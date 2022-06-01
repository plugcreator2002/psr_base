import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "it";

  static m4(value) {
    return "Il valore di questo campo deve essere uguale a $value.";
  }

  static m0(max) => "Il valore inserito deve essere minore o uguale a $max";

  static m1(maxLength) {
    return "Il valore inserito deve avere una lunghezza minore o uguale a $maxLength";
  }

  static m2(min) {
    return "Il valore inserito deve essere maggiore o uguale a $min.";
  }

  static m3(minLength) {
    return "Il valore inserito deve avere una lunghezza maggiore o uguale a $minLength";
  }

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "Questo campo richiede un numero di carta di credito valido.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "Questo campo richiede una data valida.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "Questo campo richiede un indirizzo email valido.",
      ),
      "equalErrorText": m4,
      "integerErrorText": MessageLookupByLibrary.simpleMessage(
        "Il valore deve essere un integer.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "Questo campo richiede un indirizzo IP valido.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "Il valore non corrisponde al formato richiesto.",
      ),
      "maxErrorText": m0,
      "maxLengthErrorText": m1,
      "minErrorText": m2,
      "minLengthErrorText": m3,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "Il valore deve essere numerico.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "Questo campo non può essere vuoto.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "Questo campo richiede una URL valida.",
      ),
    };
  }
}
