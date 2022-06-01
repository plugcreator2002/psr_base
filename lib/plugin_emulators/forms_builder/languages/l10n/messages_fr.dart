import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "fr";

  static m1(max) => "La valeur doit être inférieure ou égale à $max";

  static m2(maxLength) {
    return "La valeur doit avoir une longueur inférieure ou égale à $maxLength";
  }

  static m3(min) => "La valeur doit être supérieure ou égale à $min.";

  static m4(minLength) {
    return "La valeur doit avoir une longueur supérieure ou égale à $minLength";
  }

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "Ce champ nécessite un numéro de carte de crédit valide.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "Ce champ nécessite une chaîne de date valide.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "Ce champ nécessite une adresse e-mail valide.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "Ce champ nécessite une adresse IP valide.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "La valeur ne correspond pas au modèle.",
      ),
      "maxErrorText": m1,
      "maxLengthErrorText": m2,
      "minErrorText": m3,
      "minLengthErrorText": m4,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "La valeur doit être numérique.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "Ce champ ne peut pas être vide.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "Ce champ nécessite une adresse URL valide.",
      ),
    };
  }
}
