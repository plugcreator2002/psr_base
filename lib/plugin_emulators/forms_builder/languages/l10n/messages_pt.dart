import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "pt";

  static m1(max) => "O valor deve ser menor ou igual a $max";

  static m2(maxLength) {
    return "O valor deve ter um comprimento menor ou igual a $maxLength";
  }

  static m3(min) => "O valor deve ser maior ou igual a $min.";

  static m4(minLength) {
    return "O valor deve ter um comprimento maior ou igual a $minLength";
  }

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requer um número de cartão de crédito válido.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requer uma string de data válida.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requer um endereço de e-mail válido.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requer um IP válido.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "O valor não corresponde ao padrão.",
      ),
      "maxErrorText": m1,
      "maxLengthErrorText": m2,
      "minErrorText": m3,
      "minLengthErrorText": m4,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "O valor deve ser numérico.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo não pode ficar vazio.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requer um endereço de URL válido.",
      ),
    };
  }
}
