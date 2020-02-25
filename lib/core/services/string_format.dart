import 'package:intl/intl.dart';
// TODO: Better handle nulls and data types

String formatNumber(dynamic inputNumber) {
  List<String> nullList = ['null', ''];
  // , 'NA', 'NaN'];
  // final formatter = new NumberFormat.decimalPattern();
  if (nullList.contains(inputNumber)) {
    return '';
  } else {
    var formatter = NumberFormat('##,##,##,##,###.##', 'en_IN');
    return formatter.format(double.parse(inputNumber));
  }
}

String formatIndianCurrency(dynamic inputNumber) {
  List<String> nullList = ['null', ''];
  // , 'NA', 'NaN'];
  // final formatter = new NumberFormat.decimalPattern();
  if (nullList.contains(inputNumber)) {
    return '';
  } else {
    var formatter = NumberFormat('##,##,##,##,###.##', 'en_IN');
    return '\u20B9' + formatter.format(double.parse(inputNumber));
  }
}
