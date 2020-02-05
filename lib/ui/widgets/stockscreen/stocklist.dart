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
  @override
  Widget build(BuildContext context) {

    final stockItemData = Provider.of<List<StockItem>>(context);
    

    List<StockItem> stockItemDataforDisplay = stockItemData;



    _searchBar() {
        // var stockItemData = Provider.of<List<StockItem>>(context);

  return Padding(
    padding: spacer.x.sm,
    child: TextField(decoration: InputDecoration(
      hintText: 'Search...',
      prefixIcon: Icon(Icons.search),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))
    ),
    onChanged: (text) {
      text = text.toLowerCase();
      setState( () {
        if (text.length == 0) {
          stockItemDataforDisplay = stockItemData;
        } else {

        stockItemDataforDisplay = stockItemData.where((item) {
          var name = item.name.toLowerCase();
          return name.contains(text);
          }).toList();

        }
        });

      }
    )
  ); 
}

      
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Padding(
            padding: spacer.all.xxs,
            child: Text('Total Stock Items: ${stockItemData.length}'),
          ),
              Container(
                padding: spacer.bottom.xs,
          child: _searchBar(),
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
      )
      
     
    );
  }



}


