import 'package:intl/intl.dart';

// TODO: Better handle nulls and data types

String formatNumber(dynamic inputNumber) {
  // final formatter = new NumberFormat.decimalPattern();
  var formatter = NumberFormat('##,##,##,##,###.##', 'en_IN');  
  return formatter.format(double.parse(inputNumber));
}

String formatIndianCurrency(dynamic inputNumber) {
  // final formatter = new NumberFormat.decimalPattern();
  var formatter = NumberFormat('##,##,##,##,###.##', 'en_IN');  
  return '\u20B9'+formatter.format(double.parse(inputNumber));
}
