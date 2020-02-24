import 'package:tassist/core/models/vouchers.dart';

List<String> timePeriodList = [
  'Everything',
  'Today',
  'This month',
  'Current FY',
  'FY 2017-18'
];

Iterable<Voucher> filterVouchersByTimePeriod(voucherList, period) {
  // TODO: Handle timezone differences

  var now = new DateTime.now();

  if (period == 'Everything') {
    return voucherList;
  }
  if (period == 'Today') {
    voucherList = voucherList.where(
      // (voucher) => voucher.date == new DateTime(2015, 10, 09),
      (voucher) => voucher.date == new DateTime(now.year, now.month, now.day),
    );
  }
  // else if (period == "Yesterday") {}
  // else if (period == "This week") {}
  // else if (period == "Last 7 days") {}
  else if (period == "This month") {
    voucherList = voucherList.where(
      (voucher) => ((voucher.date.month == now.month) &&
          (voucher.date.year == now.year)),
    );
  }
  // else if (period == "Last 30 days") {}
  else if (period == "Current FY") {
    if ([1, 2, 3].contains(now.month)) {
      voucherList = voucherList.where(
        (voucher) => voucher.date >= new DateTime(now.year - 1, 4, 1),
      );
    } else {
      voucherList = voucherList.where(
        (voucher) => voucher.date >= new DateTime(now.year, 4, 1),
      );
    }

    // print(voucherList);
  }
  // else if (period == "Last FY") {
  // }

  print(voucherList);
  return voucherList;
}
