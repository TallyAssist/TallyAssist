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
    return Card(
          elevation: 10.0,
          child: Padding(
            padding: spacer.all.xs,
            child: Column(children: <Widget>[
        Row(children: <Widget>[
            Text(_title1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.title.copyWith(
                    fontSize: 16.0,
                )
                ),
        ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(info1, style: Theme.of(context).textTheme.body1),
                  Text(
                    info2,
                    style: Theme.of(context).textTheme.body1,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(info3,
                      style: Theme.of(context).textTheme.body1.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  Text(info4, style: Theme.of(context).textTheme.body1)
                ],
              )
            ],
        ),
      ]),
          ),
    );
  }
}
