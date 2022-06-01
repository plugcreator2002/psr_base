import "package:intl/message_lookup_by_library.dart";

final messages = MessageLookup();

typedef MessageIfAbsent = String Function(
  String messageStr,
  List<dynamic> args,
);

class MessageLookup extends MessageLookupByLibrary {
  @override
  String get localeName => "ja";

  static m4(value) => "$valueに一致していません。";

  static m0(max) => "$max以下にしてください。";

  static m1(maxLength) => "$maxLength文字以下で入力してください。";

  static m2(min) => "$min以上にしてください。";

  static m3(minLength) => "$minLength文字以上で入力してください。";

  static m5(value) => "$valueと違うものにしてください。";

  @override
  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) {
    return <String, Function>{
      "creditCardErrorText": MessageLookupByLibrary.simpleMessage(
        "有効なクレジットカード番号を入力してください。",
      ),
      "dateStringErrorText": MessageLookupByLibrary.simpleMessage(
        "正しい日付を入力してください。",
      ),
      "emailErrorText": MessageLookupByLibrary.simpleMessage(
        "有効なメールアドレスを入力してください。",
      ),
      "equalErrorText": m4,
      "integerErrorText": MessageLookupByLibrary.simpleMessage(
        "整数で入力してください。",
      ),
      "ipErrorText": MessageLookupByLibrary.simpleMessage(
        "有効なIPアドレスを入力してください。",
      ),
      "matchErrorText": MessageLookupByLibrary.simpleMessage(
        "有効な正規表現を指定してください。",
      ),
      "maxErrorText": m0,
      "maxLengthErrorText": m1,
      "minErrorText": m2,
      "minLengthErrorText": m3,
      "notEqualErrorText": m5,
      "numericErrorText": MessageLookupByLibrary.simpleMessage(
        "半角数字で入力してください。",
      ),
      "requiredErrorText": MessageLookupByLibrary.simpleMessage(
        "必須項目です。",
      ),
      "urlErrorText": MessageLookupByLibrary.simpleMessage(
        "有効なURLを入力してください。",
      ),
    };
  }
}
