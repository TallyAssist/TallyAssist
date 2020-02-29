import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/receivables.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/itemlist.dart';
import 'package:tassist/ui/views/ledgerview.dart';

class ARLedgerItemList extends StatefulWidget {
  @override
  _ARLedgerItemListState createState() => _ARLedgerItemListState();
}

class _ARLedgerItemListState extends State<ARLedgerItemList> {


TextEditingController editingController = TextEditingController();

  List<ReceivablesItem> ledgerItemData;
  List<ReceivablesItem> ledgerItemDataforDisplay= List<ReceivablesItem>();

  @override
  void initState() {
    ledgerItemData = Provider.of<List<ReceivablesItem>>(context, listen: false);
    ledgerItemDataforDisplay.addAll(ledgerItemData);

    super.initState();
  }

  void filterSearchResults(String query) {
    List<ReceivablesItem> dummySearchList = List<ReceivablesItem>();
    dummySearchList.addAll(ledgerItemData);
    if (query.isNotEmpty) {
      List<ReceivablesItem> dummyListData = List<ReceivablesItem>();
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

    String partyname;
    String ledgerGuid;
  
              return  Container(
            height: MediaQuery.of(context).size.height / 1.1,
            child: Column(
              children: <Widget>[
                 Padding(
              padding: spacer.all.xxs,
              child: Text('Total Accounts Receivables: ${ledgerItemData.length}', style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.normal),),
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
                Text( 'Outstandings', style: TextStyle(color: TassistBlack, fontWeight: FontWeight.bold),),
                // Text ('Receipts', style: TextStyle(color: TassistInfoGrey, fontWeight: FontWeight.bold ),),
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
                      return GestureDetector(
                      onDoubleTap: () => {
            
                        partyname = ledgerItemDataforDisplay[index].name,
                        ledgerGuid = ledgerItemDataforDisplay[index].guid,
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => LedgerView(ledgerGuid: ledgerGuid, partyname: partyname,))
                        )
                      },
                      child: SingleItem(ledgerItem: ledgerItemDataforDisplay[index])
                      );
                    },
                  ),
                ),
              ],
            ));
          }
  }

