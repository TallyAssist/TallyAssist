import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';


class ColoredIconNumberRow extends StatefulWidget {
  final String metric;
  final String mTitle;
  ColoredIconNumberRow(this.metric, this.mTitle);

  @override
  _ColoredIconNumberRowState createState() =>
      _ColoredIconNumberRowState();
}

class _ColoredIconNumberRowState extends State<ColoredIconNumberRow> {

  @override
  Widget build(BuildContext context) {

    final snapshot = Provider.of<DocumentSnapshot>(context);

    var userDocument = snapshot?.data; 

  if (snapshot?.data != null) {
    return Padding(
      padding: spacer.y.xxs,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.arrow_drop_up,
                color: TassistSuccess,
                size: 30.0,
              ),
              Text(
                userDocument[widget.metric].toString(),
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                    color: TassistSuccess),
              ),
            ],
          ),
          Container(
             child: Text(
              widget.mTitle,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.headline6.copyWith(
                fontSize: 12,
                color: TassistMainText
              ),
            ),
          )
        ],
      ),
    );
  }
       else {
  return Container(
    child: Center(child: Text('Whatever'),),
  );
}
}
}