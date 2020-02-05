import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/partyscreen/ledgertile.dart';

class LedgerItemList extends StatefulWidget {
  @override
  _LedgerItemListState createState() => _LedgerItemListState();
}

class _LedgerItemListState extends State<LedgerItemList> {
  @override
  Widget build(BuildContext context) {
    final ledgerItemData = Provider.of<List<LedgerItem>>(context);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Ledgers: ${ledgerItemData.length}'),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ledgerItemData?.length ?? 0,
                itemBuilder: (context, index) {
                  return LedgerItemTile(ledgerItem: ledgerItemData[index]);
                },
              ),
            ),
          ],
        ));
  }
}
