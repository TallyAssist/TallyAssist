import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/childdetailcard.dart';


class LedgerCard extends StatelessWidget {


  final String category;
  final ChildDetailCard childdetailCard;
  final String title1;
  final String info1;
  final String title2;
  final String info2;
  final String title3;
  final String info3;

  LedgerCard({this.category, this.childdetailCard, this.title1, this.info1, this.title2, this.info2, this.title3, this.info3});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      elevation: 0.5,
      // margin: spacer.all.xxs,
      child: Padding(
              padding: spacer.all.xxs,
              child: ExpansionTile(
          backgroundColor: Colors.white,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.powerOff, color: TassistWarning, size: 20.0),
                  SizedBox(width: 8.0,),
                   Icon(FontAwesomeIcons.arrowCircleDown, color: TassistSuccess, size: 20.0),
                  SizedBox(width: 8.0,),
                  Container(
                    decoration: ShapeDecoration(
                      color: TassistInfoLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )
                    ),
                    child: Padding(
                      padding: spacer.x.xxs,
                      child: Text('Creditor', style: Theme.of(context).textTheme.body1.copyWith(
                        fontSize: 12.0
                      )),
                    )
                  ),
                  

                ]
              ), 
              childdetailCard,
            ],
          ),
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