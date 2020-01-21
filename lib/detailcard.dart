import 'package:flutter/material.dart';
import 'package:tassist/theme/dimensions.dart';

class DetailCard extends StatelessWidget {

  final String _title1;
  final String info1;
  final String info2;
  final String info3;
  final String info4;

  DetailCard(this._title1, this.info1, this.info2, this.info3, this.info4);


  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: <Widget>[
        Padding(
          padding: spacer.all.xs,
          child: Column(children: <Widget>[
            Text(_title1, style: Theme.of(context).textTheme.title),
            Text(info1, style: Theme.of(context).textTheme.body1)
          ],),
        ),
        Padding(
          padding: spacer.all.xs,
          child: Column(children: <Widget>[
            Text(info2)
          ],),
        ),
        Padding(
          padding: spacer.all.xs,
          child: Column(children: <Widget>[
            Text(info3, style: Theme.of(context).textTheme.body1),
            Text(info4,  style: Theme.of(context).textTheme.body1)
          ],

          ),
        )

      ],

      
    );
  }
}