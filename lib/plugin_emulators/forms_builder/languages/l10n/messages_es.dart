import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "es";

  static m1(max) => "El valor debe ser menor o igual que $max.";

  static m2(maxLength) {
    return "El valor debe tener una longitud menor o igual a $maxLength";
  }

  static m3(min) => "El valor debe ser mayor o igual que $min.";

  static m4(minLength) {
    return "El valor debe tener una longitud mayor o igual a $minLength";
  }

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requiere un número de tarjeta de crédito válido.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requiere una cadena de fecha válida.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requiere una dirección de correo electrónico válida.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requiere una IP válida.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "El valor no coincide con el patrón requerido.",
      ),
      "maxErrorText": m1,
      "maxLengthErrorText": m2,
      "minErrorText": m3,
      "minLengthErrorText": m4,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "El valor debe ser numérico.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo no puede estar vacío.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "Este campo requiere una dirección URL válida.",
      ),
    };
  }
}
