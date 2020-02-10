import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/partyscreen/ledgertile.dart';



class InactiveCustomerList extends StatefulWidget {
  @override
  _InactiveCustomerListState createState() => _InactiveCustomerListState();
}

class _InactiveCustomerListState extends State<InactiveCustomerList> {
  @override
  Widget build(BuildContext context) {
    final inactiveCustomerData = Provider.of<List<LedgerItem>>(context);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Inactive Customers: ${inactiveCustomerData.length}', style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: inactiveCustomerData?.length ?? 0,
                itemBuilder: (context, index) {
                  return LedgerItemTile(ledgerItem: inactiveCustomerData[index]);
                },
              ),
            ),
          ],
        ));
  }
}
