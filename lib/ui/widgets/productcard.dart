import 'package:flutter/material.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/theme/theme.dart';

class ProductCard extends StatelessWidget {
  final String _title1;
  final String subtitle;
  final String info1;
  final String info2;
  final String info3;
  final String info4;

  ProductCard(this._title1, this.subtitle, this.info1, this.info2, this.info3, this.info4);

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 5.0,
          child: Padding(
            padding: spacer.all.xs,
            child: Column(children: <Widget>[
        Row(children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                   Text(_title1,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                      fontSize: 16.0,
                  )
                  ),
                  
                  Text(subtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: secondaryHint
                  )
                ]
              )
                         ),
        ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(info1, style: Theme.of(context).textTheme.bodyText1),
                  Text(
                    info2,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(info3,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                  Text(info4, style: Theme.of(context).textTheme.bodyText1)
                ],
              )
            ],
        ),
      ]),
          ),
    );
  }
}
