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
    
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Padding(
            padding: spacer.all.xxs,
            child: Text('Total Stock Items: ${stockItemData.length}'),
          ),
          Expanded(
            child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true, 
            itemCount: stockItemData?.length ?? 0,
            itemBuilder: (context, index) {
              return StockItemTile(stockItem: stockItemData[index]);
            },
      ),
          ),

        ],
      )
      
     
    );
  }
}




