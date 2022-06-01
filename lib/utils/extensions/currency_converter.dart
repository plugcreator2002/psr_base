import 'package:psr_base/index.dart' show Utility, GameStrings;

extension MoneyConverter on String {
  String get toToman {
    if (isEmpty) return "0";
    final strNumber = Utility.extract(this);
    final convertedNumber = int.parse(strNumber);
    return (convertedNumber / 10).toString();
  }

  String get toRial {
    final strNumber = Utility.extract(this);
    final convertedNumber = int.parse(strNumber);
    return (convertedNumber * 10).toString();
  }

  String toMillion([String unit = " میلیون تومان"]) {
    final entrance = replaceAll(",", "");

    if (entrance.isEmpty || int.parse(entrance) < 10000000) {
      return "0 $unit";
    }
    String str = entrance.toToman;
    List<String> splits = str.split("");

    str = str.substring(0, splits.length - 8);

    return str.withCommas() + unit;
  }
}
