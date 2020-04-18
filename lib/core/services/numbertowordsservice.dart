import 'package:intl/intl.dart';

class NumberWordsSpelling {
  static String toIndianCurrency(String number) {
    String _words = "";
    String _result = "";
    if (number == null || number == "") {
      return '';
    }
    _words = IndianCurrencyFromNumber.toWord(number);

    _result = _words.replaceAll("^\\s+", "").replaceAll("\\b\\s{2,}\\b", " ");
    return _result.trim();
  }
}

class IndianCurrencyFromNumber {
  static String toWord(String pnumber) {
    double number = double.parse(pnumber);
// 0 to 999999999.99
    if (number == 0) {
      return "zero";
    }
// pad with "0"
    String mask = "000000000.00";
    final df = new NumberFormat(mask);
    String snumber = df.format(number);
// XXnnnnnnn.nn
    int crore = int.parse(snumber.substring(0, 2));
// nnXXnnnnn.nn
    int lakh = int.parse(snumber.substring(2, 4));
// nnXXnnnnn.nn
    int thousand = int.parse(snumber.substring(4, 6));
// nnnnnnXXX.nn
    int hundred = int.parse(snumber.substring(6, 9));
// nnnnnn.XX
    int paisa = int.parse(snumber.substring(10, 12));

    String tradCrore;

    switch (crore) {
      case 0:
        tradCrore = "";
        break;
      case 1:
        tradCrore = _convertLessThanOneThousand(crore) + " crore ";
        break;
      default:
        tradCrore = _convertLessThanOneThousand(crore) + " crore ";
    }
    String result = tradCrore;

    String tradLakh;

    switch (lakh) {
      case 0:
        tradLakh = "";
        break;
      case 1:
        tradLakh = _convertLessThanOneThousand(lakh) + " lakh ";
        break;
      default:
        tradLakh = _convertLessThanOneThousand(lakh) + " lakh ";
    }
    result = result + tradLakh;

    String tradThousand;
    switch (thousand) {
      case 0:
        tradThousand = "";
        break;
      case 1:
        tradThousand = _convertLessThanOneThousand(thousand) + " thousand ";
        break;
      default:
        tradThousand = _convertLessThanOneThousand(thousand) + " thousand ";
    }
    result = result + tradThousand;

    String tradHundred;
    tradHundred = _convertLessThanOneThousand(hundred);
    result = result + tradHundred;

    String tradPaisa;
    switch (paisa) {
      case 0:
        tradPaisa = "";
        break;
      case 1:
        tradPaisa = " and " + _convertLessThanOneThousand(paisa) + " paisa ";
        break;
      default:
        tradPaisa = " and " + _convertLessThanOneThousand(paisa) + " paisa ";
    }
    result = result + tradPaisa;

    return result + " only";
  }

  static String _convertLessThanOneThousand(int number) {
    List<String> tensNames = [
      "",
      " ten",
      " twenty",
      " thirty",
      " forty",
      " fifty",
      " sixty",
      " seventy",
      " eighty",
      " ninety"
    ];

    List<String> numNames = [
      "",
      " one",
      " two",
      " three",
      " four",
      " five",
      " six",
      " seven",
      " eight",
      " nine",
      " ten",
      " eleven",
      " twelve",
      " thirteen",
      " fourteen",
      " fifteen",
      " sixteen",
      " seventeen",
      " eighteen",
      " nineteen"
    ];
    String soFar;
    if (number % 100 < 20) {
      soFar = numNames[number % 100];
      number = number ~/ 100;
    } else {
      soFar = numNames[number % 10];
      number = number ~/ 10;
      soFar = tensNames[number % 10] + soFar;
      number = number ~/ 10;
    }
    if (number == 0) return soFar;
    return numNames[number] + " hundred" + soFar;
  }
}
