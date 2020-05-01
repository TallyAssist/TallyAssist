import 'package:flutter/material.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/childdetailcard.dart';


class ExpansibleDetailCard extends StatelessWidget {

  final ChildDetailCard childdetailCard;
  final String title1;
  final String info1;
  final String title2;
  final String info2;
  final String title3;
  final String info3;

  ExpansibleDetailCard({this.childdetailCard, this.title1, this.info1, this.title2, this.info2, this.title3, this.info3});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      elevation: 1,
      // margin: spacer.all.xxs,
      child: Padding(
              padding: spacer.all.xxs,
              child: ExpansionTile(
          backgroundColor: Colors.white,
          title: childdetailCard,

          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Row(
                children: <Widget>[
                  Text(title1),
                  Spacer(),
                  Text(info1),
                ],
              ),
            ),
            Padding(
              padding: spacer.all.xxs,
              child: Row(
                children: <Widget>[
                  Text(title2),
                  Spacer(),
                  Text(info2),
                ],
              ),
            ),
            Padding(
              padding: spacer.all.xxs,
              child: Row(
                children: <Widget>[
                  Text(title3),
                  Spacer(),
                  Text(info3),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}