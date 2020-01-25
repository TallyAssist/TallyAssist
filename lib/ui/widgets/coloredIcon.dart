import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';


class ColoredIconNumberRow extends StatefulWidget {
  final String metric;
  final String mTitle;
  ColoredIconNumberRow(this.metric, this.mTitle);

  @override
  _ColoredIconNumberRowState createState() =>
      _ColoredIconNumberRowState(metric, mTitle);
}

class _ColoredIconNumberRowState extends State<ColoredIconNumberRow> {
  final String mTitle;
  final String metric;


  _ColoredIconNumberRowState(this.metric, this.mTitle);
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                metric,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: TassistSuccess),
              ),
            ],
          ),
          Container(
             child: Text(
              mTitle,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 12,
                color: TassistMainText
              ),
            ),
          )
        ],
      ),
    );
  }
}
