
import 'package:flutter/material.dart';
import 'package:tassist/theme/theme.dart';

class BigMetricNoIcon extends StatelessWidget {

final metric;
final mTitle;
final color;

BigMetricNoIcon(this.metric, this.mTitle, this.color);


  @override
  Widget build(BuildContext context) {
      return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                metric,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: color),
              ),
            ],
          ),
          Container(
             child: Text(
              mTitle,
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
}

