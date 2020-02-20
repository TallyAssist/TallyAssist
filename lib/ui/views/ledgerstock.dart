import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledgerstock.dart';
import 'package:tassist/ui/widgets/childdetailcard.dart';
import 'package:tassist/ui/widgets/expansibledetailcard.dart';


class LedgerStockView extends StatelessWidget {

  final String ledgerGuid;

  LedgerStockView({this.ledgerGuid});



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
  
  final LedgerStock ledgerStock;

  LedgerStockTile({this.ledgerStock});

  @override
  Widget build(BuildContext context) {
    return ExpansibleDetailCard(
      childdetailCard: ChildDetailCard('Total: ${ledgerStock.totalAmount}', 'info1', 'info2', 'info3', 'info4'),
      title1: '',
      info1: '',
      title2: '',
      info2: '',
      title3: '',
      info3: '',
    );
  }
}