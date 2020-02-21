import 'package:flutter/material.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:intl/intl.dart';

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
      child: DetailCard(salesVoucher.partyname, '# ${salesVoucher.masterid}',  salesVoucher.iscancelled, 'Rs. ${salesVoucher.amount.toString()}', _formatDate(salesVoucher.date),)
      
    );
  }
}