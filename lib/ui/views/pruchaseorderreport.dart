import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/views/accountspayablescreen.dart';
import 'package:tassist/ui/views/ledgerscreen.dart';
import 'package:tassist/ui/views/stockscreen.dart';
import 'package:tassist/ui/widgets/coloredIcon.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:tassist/ui/widgets/filterbar.dart';
import 'package:tassist/ui/widgets/gotobar.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';


class PurchaseOrderReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
        final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    
    return  MultiProvider(
      providers: [
        StreamProvider<DocumentSnapshot>.value(value: DatabaseService(uid: user.uid).metricCollection.document(user.uid).snapshots()),
        ],
  

      child:  WillPopScope (
              onWillPop: () async => false,
              child: Scaffold(
          key: _drawerKey,
          drawer: tassistDrawer(context),
        appBar: headerNav(_drawerKey),
        // bottomNavigationBar: bottomNav(),
        body: ListView(
          children: <Widget>[
            SectionHeader('Purchase Order Report'),
            Container(
             
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: spacer.x.xs,
                      margin: spacer.all.xxs,
                      color: Color(0xffEDF4FC),
                      child: Row(
                        children: <Widget>[
                          Text('Product'),
                          Icon(Icons.arrow_drop_down, color: Colors.purple[800]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: spacer.x.xs,
                       margin: spacer.all.xxs,
                      color: Color(0xffEDF4FC),
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
                    ColoredIconNumberRow('total_purchases', 'Spent So Far'),
                    ColoredIconNumberRow('open_purchase_orders', 'Open Orders'),
                  ],
                ),
                Column(
                  children: <Widget>[
                    ColoredIconNumberRow('purchase_order_qty', 'Ordered Qty'),
                    ColoredIconNumberRow('purchase_qty_due', 'Quantity Due'),
                  ],
                )
              ],
            ),
            FilterBar('Pending Purcahse Order By', 'Due Date'),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),
              DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),
              DetailCard('XYZ Pvt. Ltd.', '#12483', '23 days', 'Rs. 1,23,890', '450 Nos.'),

              ],
            ),
            GoToBar('Top Suppliers', LedgerScreen()),
            GoToBar('Top Items Due', StockScreen()),
            GoToBar('Top Accounts Payable', AccountsPayableScreen())       
          ],
        ),
    ),
      )
    );
  }
}