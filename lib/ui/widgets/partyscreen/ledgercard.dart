import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/childdetailcard.dart';
import 'package:url_launcher/url_launcher.dart';



class LedgerCard extends StatelessWidget {


  final String category;
  final ChildDetailCard childdetailCard;
  final String title1;
  final String info1;
  final String title2;
  final String info2;
  final String title3;
  final String info3;
  // final String title4;
  // final String info4;
  final LedgerItem ledgerItem;
  

  LedgerCard({this.category, this.childdetailCard, this.title1, this.info1, this.title2, this.info2, this.title3, this.info3, this.ledgerItem});

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
 
_changeCreditorDebtor() {
  if (ledgerItem.parentid == '20') {
    return  Container(
                    decoration: ShapeDecoration(
                      color: TassistInfoLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )
                    ),
                    child: Padding(
                      padding: spacer.x.xxs,
                      child: Text('Debtor', style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 12.0
                      ))
                     
                    )
                  );
    
  }
  else {
  return Container(
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
                  );
  }

}

_changeReceivables() {
 if ((ledgerItem.totalReceivables != '0.0') ) {
return Icon(FontAwesomeIcons.arrowCircleDown, color: TassistSuccess, size: 20.0);
}
else if ((ledgerItem.totalPayables != '0.0')) {
return Icon(FontAwesomeIcons.arrowCircleUp, color: TassistWarning, size: 20.0);
}
else {
    return Icon(FontAwesomeIcons.circle, color: TassistInfoBlue, size: 20.0);
  }
}

_changeActiveStatus() {
if (ledgerItem.closingBalance == 0) {
 return Icon(FontAwesomeIcons.powerOff, color: TassistWarning, size: 20.0);
}
else {
  return Icon(FontAwesomeIcons.powerOff, color: TassistSuccess, size: 20.0);
}
}


    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      elevation: 8.0,
      // margin: spacer.all.xxs,
      child: ExpansionTile(
          backgroundColor: Colors.white,
          subtitle: childdetailCard,
          
  title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
      Row(
        children: <Widget>[

        // _changeActiveStatus(),
        //   SizedBox(width: 8.0,),
        _changeReceivables(),
          SizedBox(width: 8.0,),
          _changeCreditorDebtor(),   
        Spacer(),

        IconButton(icon: Icon(FontAwesomeIcons.whatsapp), onPressed: () => _launchURL()  ),
        IconButton(icon: Icon(FontAwesomeIcons.bell), onPressed: () {
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Coming Soon!'),
                content: Text('Reminders are in the works, you will see them by end of the week latest!', style: Theme.of(context).textTheme.bodyText1,),
                actions: <Widget>[
                  FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text("I'll wait :)", style: TextStyle(fontSize: 20.0, color: TassistPrimaryBackground),))
                ],
              );

            }
          
          );
        } ),  
        

        ]
      ), 


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
            ),
            // Padding(
            //   padding: spacer.all.xxs,
            //   child: Row(
            //     children: <Widget>[
            //       Text(title4),
            //       Spacer(),
            //       Text(info4),
            //     ],
            //   ),
            // ),
            FlatButton(onPressed: () => Navigator.of(context).pushReplacementNamed('/ledgerview'), 
            child: Text('View more details', 
            style: Theme.of(context).textTheme.bodyText1.copyWith(color: TassistMenuBg),
          
            )
            )
          ],
        ),
    );
  }
}


