
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/core/models/inactivecustomer.dart';
import 'package:intl/intl.dart';
import 'package:tassist/theme/colors.dart';
// import 'package:tassist/ui/widgets/childdetailcard.dart';
// import 'package:tassist/ui/widgets/expansibledetailcard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tassist/core/services/string_format.dart';

var formatter = new DateFormat('dd-MM-yyyy');



class LedgerItemTile extends StatelessWidget {

  final InactiveCustomer ledgerItem;
  
  LedgerItemTile({this.ledgerItem});

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


    return 
    FittedBox(
          child: Card(
            borderOnForeground: true,
                      child: Row(
        children: <Widget>[
        
            SizedBox(width: 5,),
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              child: Text(ledgerItem.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 14,
                color: TassistPrimaryBackground
              ),
              ),
            ),
            SizedBox(width: 5,),
            // Text(formatIndianCurrency(ledgerItem.openingBalance ?? ''), style: TextStyle(color: TassistInfoGrey)),
            SizedBox(width: 10,),
    
               Text(formatIndianCurrency(ledgerItem.totalReceivables ?? ''),),
              IconButton(
                onPressed: () {
                  _launchURL();
                },
                icon: Icon(FontAwesomeIcons.whatsapp, color: TassistSuccess,),
              )
        ],
            
      ),
          ),
    );
  }

}  

