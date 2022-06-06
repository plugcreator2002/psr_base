class Utility {
  static String extract(String inputString) {
    String number = "";
    inputString = changeDigit(inputString);
    number = inputString.replaceAll(RegExp(r"\D"), "");
    return changeDigit(number);
  }

  static String changeDigit(String number) {
    final persianNumbers = ["۰", "۱", "۲", "۳", "۴", "۵", "۶", "۷", "۸", "۹"];
    final enNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."];

    for (int i = 0; i < 10; i++) {
      number = number.replaceAll(RegExp(persianNumbers[i]), enNumbers[i]);
    }

    return number;
  }
}
