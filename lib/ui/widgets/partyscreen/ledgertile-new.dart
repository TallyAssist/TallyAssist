
import 'package:flutter/material.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:intl/intl.dart';
import 'package:tassist/ui/widgets/childdetailcard.dart';
import 'package:tassist/ui/widgets/detailcard.dart';

import 'package:tassist/ui/widgets/partyscreen/ledgercard.dart';

var formatter = new DateFormat('dd-MM-yyyy');
// TODO
var numberFormatter = new NumberFormat('##,##,##,##,###.##', "en_US");


class LedgerItemTileNew  extends StatelessWidget {

  final LedgerItem ledgerItem;
  
  LedgerItemTileNew({this.ledgerItem});


  @override
  Widget build(BuildContext context) {


  if (ledgerItem.parentid == '20') {
     return LedgerCard(childdetailCard: ChildDetailCard(ledgerItem.name, 
    '# ${ledgerItem.masterId}',
     ledgerItem.state, 
     'Rs ${ledgerItem.closingBalance.substring(1, ledgerItem.closingBalance.length)}', 
     'Rs. ${ledgerItem.openingBalance.substring(1, ledgerItem.openingBalance.length)}'),
      title1: 'Receivables', 
      info1: ledgerItem.contact, 
      title2: 'Last Sale ', 
      info2: ledgerItem.email, 
      title3: 'Last Receipt', info3: ledgerItem.phone,
      title4: 'Last Price Sold', info4: 'NA',);
  }
  else {

  if (ledgerItem.parentid == '16') {
     return LedgerCard(childdetailCard: ChildDetailCard(ledgerItem.name, 
    '# ${ledgerItem.masterId}',
     ledgerItem.state, 
     'Rs ${ledgerItem.closingBalance.substring(1, ledgerItem.closingBalance.length)}', 
     'Rs. ${ledgerItem.openingBalance.substring(1, ledgerItem.openingBalance.length)}'),
      title1: 'Payables', 
      info1: ledgerItem.contact, 
      title2: 'Last Purchase ', 
      info2: ledgerItem.email, 
      title3: 'Last Payment', info3: ledgerItem.phone,
      title4: 'Last Price Bought', info4: 'NA',
      );

  }
  else {
    return DetailCard(ledgerItem.name, 
    '# ${ledgerItem.masterId}',
     ledgerItem.parentid, 
     'Rs ${ledgerItem.closingBalance.substring(1, ledgerItem.closingBalance.length)}', 
     'Rs. ${ledgerItem.openingBalance.substring(1, ledgerItem.openingBalance.length)}');

  }
  }
}
}