import 'package:flutter/material.dart';
import 'package:tassist/ui/widgets/detailcard.dart';


class LedgerStock extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return DetailCard('Item 1', 'Total: Rs. 12,31,201', 'Last Sale: 24/12/2019', 'Total Qty: 450 Qtl', 'Rate: Rs.234 @ 30% off');
        }
        ),
      
    );
  }
}