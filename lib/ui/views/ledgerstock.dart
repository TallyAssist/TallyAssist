import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledgerstock.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/services/string_format.dart';
import 'package:tassist/ui/shared/positiveamount.dart';

var formatter = new DateFormat('dd-MM-yyyy') ?? null;


class LedgerStockView extends StatelessWidget {
  LedgerStockView({this.ledgerGuid});

  final String ledgerGuid;

  @override
  Widget build(BuildContext context) {

    List<LedgerStock> ledgerStock;
   

    ledgerStock = Provider.of<List<LedgerStock>>(context) ?? [];

     print(ledgerStock);
    return Container(
      child: ListView.builder(
        itemCount: ledgerStock?.length,
        itemBuilder: (context, index) {
          return LedgerStockTile(ledgerStock: ledgerStock[index]);

            }
        ),
      
    );
  }
}

class LedgerStockTile extends StatelessWidget {
  LedgerStockTile({this.ledgerStock});

  final LedgerStock ledgerStock;

  @override
  Widget build(BuildContext context) {
    return DetailCard('${ledgerStock.itemName}    (${ledgerStock.numVouchers} vouchers)', 'Last Date: ${formatter.format(ledgerStock.lastDate)}',
     'Last: ${formatIndianCurrency(ledgerStock.lastAmount.toString())} @ ${formatIndianCurrency(ledgerStock.lastRate.toString())}',
      'T Amt: ${formatIndianCurrency(ledgerStock.totalAmount.toString())}', 'T Qty: ${positiveAmount(ledgerStock.totalBilledQty)}'
     
    );
  }
}