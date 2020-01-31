
import 'package:flutter/material.dart';
import 'package:tassist/core/models/khata.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:intl/intl.dart';

var formatter = new DateFormat('dd-MM-yyyy');

class KhataTile extends StatelessWidget {

  final Khata khata;
  
  
  KhataTile({this.khata});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: spacer.top.xs,
      child: Card(
        margin: spacer.all.xs,
        child: ListTile(
          leading: Container(
              child: Icon(Icons.arrow_downward),
              color: TassistBgBlue,
          ),
          title:
          
         Row(
            children: <Widget>[
              Text(khata.partyname),
              SizedBox(width: 50.0,),
              Text(khata.amount),
              SizedBox(width: 50.0,),
              Text(formatter.format(khata.date).toString()),

            ],
          )
        ),
      ),      
    );
  }
}
