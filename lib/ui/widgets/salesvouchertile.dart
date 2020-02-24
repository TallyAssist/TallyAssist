import 'package:flutter/material.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/core/services/string_format.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/services/string_format.dart';
import 'package:tassist/ui/shared/positiveamount.dart';


var formatter = new DateFormat('dd-MM-yyyy');

 _formatDate(DateTime date) {
  if (date != null) {
    return formatter.format(date);
  }
  else {
    return 'NA';
  }

}


class SalesVoucherTile extends StatelessWidget {

    final Voucher salesVoucher;

    SalesVoucherTile({this.salesVoucher});


  @override
  Widget build(BuildContext context) {

    return Container(
<<<<<<< HEAD
      child: DetailCard(salesVoucher.partyname, '# ${salesVoucher.masterid}',  salesVoucher.type, formatIndianCurrency(positiveAmount(salesVoucher.amount).toString()), _formatDate(salesVoucher.date),)
=======
      child: DetailCard(salesVoucher.partyname, '# ${salesVoucher.masterid}',  salesVoucher.iscancelled, '${formatIndianCurrency(salesVoucher.amount.toString())}', _formatDate(salesVoucher.date),)
>>>>>>> fe94c2fb777f64496f660f99d05e3e3578754ac4
      
    );
  }
}