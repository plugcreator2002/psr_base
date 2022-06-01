import 'package:psr_base/common/index.dart' show Regulars;

/// convert string to number with error controlling,
/// because we have a lot errors like that
num? numParser(data) {
  assert(
    data is num || data is String && Regulars.numberRegular.hasMatch(data),
    "this data cant be a num type", // 0
  );

  if (data is num) return data;

  return num.parse(data.toString());
}

int? intParser(String? data, [int? radix]) {
  assert(data != null, null);

  return int.tryParse(data ?? "", radix: radix);
}
