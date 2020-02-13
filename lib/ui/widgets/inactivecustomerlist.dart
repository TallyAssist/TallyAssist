import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/inactivecustomer.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/widgets/partyscreen/ledgertile.dart';



class InactiveCustomerList extends StatefulWidget {
  @override
  _InactiveCustomerListState createState() => _InactiveCustomerListState();
}

class _InactiveCustomerListState extends State<InactiveCustomerList> {
  @override
  Widget build(BuildContext context) {
    final inactiveCustomerData = Provider.of<List<InactiveCustomer>>(context);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Inactive Customers: ${inactiveCustomerData?.length}', style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),),
            ),
             Padding(
                  padding: spacer.all.xxs,
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Party Name    ', style: TextStyle(color: TassistPrimary, fontWeight: FontWeight.bold),),
                Text( 'Op Balance', style: TextStyle(color: TassistInfoGrey, fontWeight: FontWeight.bold),),
                Text ('Recievables', style: TextStyle(color: TassistBlack, fontWeight: FontWeight.bold ),),
                Icon(Icons.phone)
              ]
            ),
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
