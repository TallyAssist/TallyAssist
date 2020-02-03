
import 'package:flutter/material.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:intl/intl.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:tassist/ui/widgets/expansibledetailcard.dart';

var formatter = new DateFormat('dd-MM-yyyy');
// TODO
var numberFormatter = new NumberFormat('##,##,##,##,###.##', "en_US");


class LedgerItemTile extends StatelessWidget {

  final LedgerItem ledgerItem;
  
  LedgerItemTile({this.ledgerItem});


  @override
  Widget build(BuildContext context) {
    return ExpansibleDetailCard(detailCard: DetailCard(ledgerItem.name, 
    '# ${ledgerItem.masterId}',
     ledgerItem.state, 
     'Rs ${ledgerItem.closingBalance}', 
     'Rs. ${ledgerItem.openingBalance}'),
      title1: 'Contact', 
      info1: ledgerItem.contact, 
      title2: 'Email', 
      info2: ledgerItem.email, 
      title3: 'Phone', info3: ledgerItem.phone,);
  }
}
