
import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';

class GSTCard extends StatelessWidget {

final String title;
final String row1Title;
final String row1Number;
final String row2Title;
final String row2Number;
final String row3Title;
final String row3Number;

GSTCard(this.title, this.row1Title, this.row1Number, this.row2Title, this.row2Number, this.row3Title, this.row3Number);

 @override

  Widget build(BuildContext context) {
    return Container(
      padding: spacer.all.xs,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.headline6.copyWith(
              fontSize: 18
            ),)
            ]
          ),
          Row(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                      Text(row1Title),
                      Text(row1Number)
                      ]),

                      TableRow(
                      children: [
                      Text(row2Title),
                      Text(row2Number)
                      ]),

                      TableRow(
                      children: [
                      Text(row3Title),
                      Text(row3Number)
                      ]),   
                  ]
                      
                    )
              ),
              Flexible(
                flex: 1,
                child: Column(
                  children: <Widget>[
                    Icon(Icons.show_chart),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(Icons.refresh, color: TassistPrimary,),
                    )
                  ],
                ),
              )
            ],
          )
        ],
          
      ),
    );

}
}