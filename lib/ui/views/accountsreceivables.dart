import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';

import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/views/pruchaseorderreport.dart';
import 'package:tassist/ui/widgets/bigmetricnoicon.dart';
import 'package:tassist/ui/widgets/gotobar.dart';
import 'package:tassist/ui/widgets/itemlist.dart';
import 'package:tassist/ui/widgets/secondarysectionheader.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';



class AccountsReceivableScreen extends StatelessWidget {
  @override

  Widget build(BuildContext context) {

        final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _drawerKey,
      drawer: tassistDrawer(context),
      appBar: headerNav(_drawerKey),
      // bottomNavigationBar: bottomNav(),
      body: ListView(
        children: <Widget>[
          SectionHeader('Accounts Receivables'),
          Padding(
            padding: spacer.all.xs,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
               BigMetricNoIcon('30', '<30 days', TassistSuccess),
               BigMetricNoIcon('12', '30-45 days', TassistWarning),
               BigMetricNoIcon('16', '45-60 days', TassistDanger),
              ],
            ),
          ),
          SecondarySectionHeader('List of suppliers'),
          SingleItem('Customer 1', 'Rs. 123,456,323'),
          SingleItem('Customer 2', 'Rs. 123,456,323'),
          SingleItem('Customer 3', 'Rs. 123,456,323'),
          SingleItem('Customer 4', 'Rs. 123,456,323'),
          SingleItem('Customer 5', 'Rs. 123,456,323'),
          SingleItem('Customer 6', 'Rs. 123,456,323'),
          Padding(
            padding: spacer.y.xs,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                    Icon(Icons.mail, color: TassistPrimary,),
                    Text('Email All', style: Theme.of(context).textTheme.body1,)
                    ]
                  ),
                  Column(
                    children: <Widget>[
                    Icon(Icons.timer, color: TassistPrimary,),
                    Text('Remind All', style: Theme.of(context).textTheme.body1,)
                    ]
                  ),
                  Column(
                    children: <Widget>[
                    Icon(Icons.add_alert, color: TassistPrimary,),
                    Text('Alert Sales', style: Theme.of(context).textTheme.body1,)
                    ]
                  )
                ]
            ),
          ),
          GoToBar('Purchase Order Report', PurchaseOrderReportScreen())
          

        ],


      )


    );
  }
}