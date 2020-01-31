
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/models/production.dart';
import 'package:tassist/theme/colors.dart';
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
          leading: Container(
              child: Text(formatter.format(production.date).toString()),
              color: TassistSuccessLight,
          ),
          title: Text(production.product),
          subtitle: Text(production.production),
          

        ),
      ),      
    );
  }
}