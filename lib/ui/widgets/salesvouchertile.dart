import 'package:flutter/material.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/ui/widgets/detailcard.dart';


class SalesVoucherTile extends StatelessWidget {

    final Voucher salesVoucher;

    SalesVoucherTile({this.salesVoucher});


  @override
  Widget build(BuildContext context) {

    return Container(
      child: DetailCard(salesVoucher.partyname, '# ${salesVoucher.masterid}',  salesVoucher.iscancelled, 'Rs. ${salesVoucher.amount.toString()}', salesVoucher.date.toString()),
      
    );
  }
}