import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/production.dart';
import 'package:tassist/ui/widgets/productionTile.dart';


class ProductionList extends StatefulWidget {
  @override
  _ProductionListState createState() => _ProductionListState();
}

class _ProductionListState extends State<ProductionList> {
  @override
  Widget build(BuildContext context) {
    
    final productionData = Provider.of<List<Production>>(context);
    
    
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: false, 
          itemCount: productionData?.length ?? 0,
          itemBuilder: (context, index) {
            return ProductionTile(production: productionData[index]);
          },
      ),
    );
  }
}
