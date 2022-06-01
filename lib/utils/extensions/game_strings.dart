extension GameStrings on Object {
  String withCommas([final String pattern = ","]) {
    RegExp reg = RegExp(r"(\d{1,3})(?=(\d{3})+(?!\d))");
    String Function(Match match) mathFunction;
    mathFunction = (match) => "${match[1]}$pattern";

    return toString().replaceAllMapped(reg, mathFunction);
  }
}
