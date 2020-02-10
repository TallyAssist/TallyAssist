import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/stockitem.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/stockscreen/stocktile.dart';

class StockItemList extends StatefulWidget {
  @override
  _StockItemListState createState() => _StockItemListState();
}

class _StockItemListState extends State<StockItemList> {
  TextEditingController editingController = TextEditingController();

  List<StockItem> stockItemData;
  List<StockItem> stockItemDataforDisplay = List<StockItem>();

  @override
  void initState() {
    stockItemData = Provider.of<List<StockItem>>(context, listen: false);
    stockItemDataforDisplay.addAll(stockItemData);

    super.initState();
  }

  void filterSearchResults(String query) {
    List<StockItem> dummySearchList = List<StockItem>();
    dummySearchList.addAll(stockItemData);
    if (query.isNotEmpty) {
      List<StockItem> dummyListData = List<StockItem>();
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        stockItemDataforDisplay.clear();
        stockItemDataforDisplay.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        stockItemDataforDisplay.clear();
        stockItemDataforDisplay.addAll(stockItemData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // stockItemDataforDisplay.addAll(stockItemData);

    return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Stock Items: ${stockItemDataforDisplay.length}'),
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
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: stockItemDataforDisplay?.length ?? 0,
                itemBuilder: (context, index) {
                  return StockItemTile(stockItem: stockItemDataforDisplay[index]);
                },
              ),
            ),
          ],
        ));
  }
}
