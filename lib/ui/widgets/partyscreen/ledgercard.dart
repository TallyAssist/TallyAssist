import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/childdetailcard.dart';
import 'package:url_launcher/url_launcher.dart';

 LedgerItem ledgerItem;

class LedgerCard extends StatelessWidget {


  final String category;
  final ChildDetailCard childdetailCard;
  final String title1;
  final String info1;
  final String title2;
  final String info2;
  final String title3;
  final String info3;
  final String title4;
  final String info4;
  

  LedgerCard({this.category, this.childdetailCard, this.title1, this.info1, this.title2, this.info2, this.title3, this.info3, this.title4, this.info4,});

  @override
  Widget build(BuildContext context) {

    

_launchURL() async {
  var url = 'https://api.whatsapp.com/send?phone=${ledgerItem.phone}';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      elevation: 8.0,
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
                      child: Text('Creditor', style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 12.0
                      ))
                     
                    )
                  ),
                Spacer(),

                IconButton(icon: Icon(FontAwesomeIcons.whatsapp), onPressed: () => _launchURL()  ),
                IconButton(icon: Icon(FontAwesomeIcons.bell), onPressed: () {} ),  
                 
                  

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
            ),Padding(
              padding: spacer.all.xxs,
              child: Row(
                children: <Widget>[
                  Text(title4),
                  Spacer(),
                  Text(info4),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


