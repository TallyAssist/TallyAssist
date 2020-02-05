import 'package:flutter/material.dart';
import 'package:tassist/core/models/salesvoucher.dart';
import 'package:tassist/ui/widgets/detailcard.dart';


class SalesVoucherTile extends StatelessWidget {

    final SalesVoucher salesVoucher;

    SalesVoucherTile({this.salesVoucher});


  @override
  Widget build(BuildContext context) {

    return Container(
      child: DetailCard(salesVoucher.partyname, salesVoucher.masterid,  salesVoucher.iscancelled, 'Rs. ${salesVoucher.amount.toString().substring(1, salesVoucher.amount.toString().length)}', salesVoucher.date),
      
    );
  }
}