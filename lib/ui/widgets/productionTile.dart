
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/models/production.dart';
import 'package:tassist/theme/dimensions.dart';

var formatter = new DateFormat('dd-MM-yyyy');

class ProductionTile extends StatelessWidget {

  final Production production;
  
  ProductionTile({this.production});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: spacer.top.xs,
      child: Card(
        margin: spacer.all.xs,
        child: ListTile(
          leading: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              Icon(Icons.date_range),
              Text(formatter.format(production.date).toString()),
              ]
          ),
          title: Padding(
            padding: spacer.left.xs,
            child: Text(production.product, style: Theme.of(context).textTheme.title.copyWith(
              fontSize: 18.0
            )),
          ),
          subtitle: Padding(
            padding: spacer.left.xs,
            child: Text(production.production,  style: Theme.of(context).textTheme.body1,)
            ),
          )
          )
    );
  }
}