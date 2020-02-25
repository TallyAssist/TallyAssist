import 'package:tassist/core/models/vouchers.dart';

List<String> timePeriodList = [
  'Everything',
  'Today',
  'This month',
  'Current FY',
  'FY 2018-19',
  'FY 2017-18'
];

Iterable<Voucher> filterVouchersByTimePeriod(
    Iterable<Voucher> voucherList, String period) {
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
        (voucher) => voucher.date.isAfter(DateTime(now.year - 1, 3, 31)),
      );
    } else {
      voucherList = voucherList.where(
        (voucher) => voucher.date.isAfter(DateTime(now.year, 3, 31)),
      );
    }
  } else if (period == "FY 2018-19") {
    voucherList = voucherList.where(
      (voucher) => (voucher.date.isAfter(DateTime(2018, 3, 31)) &&
          voucher.date.isBefore(DateTime(2019, 4, 1))),
    );
  } else if (period == "FY 2017-18") {
    voucherList = voucherList.where(
      (voucher) => (voucher.date.isAfter(DateTime(2017, 3, 31)) &&
          voucher.date.isBefore(DateTime(2018, 4, 1))),
    );
  }
  // else if (period == "Last FY") {
  // }

  return voucherList;
}
