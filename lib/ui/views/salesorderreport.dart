import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/shared/bottomnav.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/widgets/coloredIcon.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:tassist/ui/widgets/filterbar.dart';
import 'package:tassist/ui/widgets/gotobar.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';





class SalesOrderReportScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

     final user = Provider.of<FirebaseUser>(context);
         final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    
    return  MultiProvider(
      providers: [
        StreamProvider<DocumentSnapshot>.value(value: DatabaseService().metricCollection.document(user.uid).snapshots()),
        // StreamProvider<DocumentSnapshot>.value(value: DatabaseService().productCollection.document(user.uid).snapshots()),
      ],
  

          child: Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
          appBar: headerNav(_drawerKey),
          bottomNavigationBar: bottomNav(),
          body: ListView(
            children: <Widget>[
              SectionHeader('Sales Report'),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: spacer.x.xs,
                        margin: spacer.all.xxs,
                        color: TassistBgBlue,
                        child: Row(
                          children: <Widget>[
                            Text('abc'),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: spacer.x.xs,
                        margin: spacer.all.xxs,
                        color: TassistBgBlue,
                        child: Row(
                          children: <Widget>[
                            Text('Customer'),
                            Icon(Icons.arrow_drop_down, color: Colors.purple[800]),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ColoredIconNumberRow('amt_sold', 'Amount Sold'),
                      ColoredIconNumberRow('open_sales_orders', 'Open Orders'),
                      ColoredIconNumberRow('amt_sales_return', 'Sales Return'),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      ColoredIconNumberRow('qty_sales_order', 'Ordered Qty'),
                      ColoredIconNumberRow('qty_sales_due', 'Quantity Due'),
                      ColoredIconNumberRow('sales_discount', 'Discount'),
                    ],
                  )
                ],
              ),
                FilterBar('Pending Sales Vouchers By', 'Due Date'),
                 Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),
                DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),
                DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),
                DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),
                DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),
                DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),

                ],
              ),
               GoToBar('Inactive Customer List')
            
            
            ],
          ),
      )
    );
  }
}

