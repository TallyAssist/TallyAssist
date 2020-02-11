import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/accountspayables/apitemlist.dart';


class APLedgerItemList extends StatefulWidget {
  @override
  _APLedgerItemListState createState() => _APLedgerItemListState();
}

class _APLedgerItemListState extends State<APLedgerItemList> {


TextEditingController editingController = TextEditingController();

  List<LedgerItem> ledgerItemData;
  List<LedgerItem> ledgerItemDataforDisplay= List<LedgerItem>();

  @override
  void initState() {
    ledgerItemData = Provider.of<List<LedgerItem>>(context, listen: false);
    ledgerItemDataforDisplay.addAll(ledgerItemData);

    super.initState();
  }

  void filterSearchResults(String query) {
    List<LedgerItem> dummySearchList = List<LedgerItem>();
    dummySearchList.addAll(ledgerItemData);
    if (query.isNotEmpty) {
      List<LedgerItem> dummyListData = List<LedgerItem>();
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        ledgerItemDataforDisplay.clear();
        ledgerItemDataforDisplay.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        ledgerItemDataforDisplay.clear();
        ledgerItemDataforDisplay.addAll(ledgerItemData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
  
              return  Container(
            height: MediaQuery.of(context).size.height / 1.1,
            child: Column(
              children: <Widget>[
                 Padding(
              padding: spacer.all.xxs,
              child: Text('Total Accounts Payable: ${ledgerItemData.length}', style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),),
            ),
               
                  Container(
                  padding: spacer.bottom.xs,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50.0,
                      child: TextField(
                        onChanged: (value) {
                          filterSearchResults(value.toLowerCase());
                        },
                        controller: editingController,
                        style: Theme.of(context).textTheme.bodyText2,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          labelText: "Search",
                          labelStyle: Theme.of(context).textTheme.bodyText2,
                          counterStyle: Theme.of(context).textTheme.bodyText2,
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(25.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                 Padding(
                  padding: spacer.all.xxs,
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Party Name    ', style: TextStyle(color: TassistPrimary, fontWeight: FontWeight.bold),),
                Text( 'Payables', style: TextStyle(color: TassistBlack, fontWeight: FontWeight.bold),),
                Text ('Payment', style: TextStyle(color: TassistInfoGrey, fontWeight: FontWeight.bold ),),
                Icon(Icons.phone)
              ]
            ),
                ),

                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: ledgerItemDataforDisplay?.length ?? 0,
                    itemBuilder: (context, index) {
                      return APSingleItem(ledgerItem: ledgerItemDataforDisplay[index]);
                    },
                  ),
                ),
              ],
            ));
          }
  }

