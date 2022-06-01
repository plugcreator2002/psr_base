import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "ar";

  static m1(max) {
    return "يجب أن تكون قيمة هذا الفراغ مساوية او اقل من $max.";
  }

  static m2(maxLength) {
    return "يجب أن يكون حجم هذا الفراغ مساوي او اقل من $maxLength.";
  }

  static m3(min) {
    return "يجب أن تكون قيمة هذا الفراغ مساوية او اكثر من $min.";
  }

  static m4(minLength) {
    return "يجب أن يكون حجم هذا الفراغ مساوي او اكثر من $minLength.";
  }

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "قيمة الفراغ ليست رقم بطاقة ائتمانيه صحيحة.",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "هذا الفراغ يتطلب تاريخ صالح.",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "هذا الفراغ يتطلب عنوان بريد إلكتروني صالح.",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "هذا الفراغ يتطلب رقم IP صالح.",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "قيمة الفراغ لا تطابق النمط.",
      ),
      "maxErrorText": m1,
      "maxLengthErrorText": m2,
      "minErrorText": m3,
      "minLengthErrorText": m4,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "قيمة الفراغ ليست رقمية.",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "هذا الفراغ يجب املاؤه.",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "هذا الفراغ يتطلب عنوان موقع URL صالح.",
      )
    };
  }
}
