import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/views/vouchers.dart';
import 'package:tassist/ui/widgets/coloredIcon.dart';
import 'package:tassist/ui/widgets/gotobar.dart';
import 'package:tassist/ui/widgets/inactivecustomerlist.dart';
import 'package:tassist/ui/widgets/secondarysectionheader.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';

class SalesOrderReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return MultiProvider(
        providers: [
          StreamProvider<DocumentSnapshot>.value(
              value: DatabaseService(uid: user?.uid)
                  .metricCollection
                  .document(user.uid)
                  .snapshots()),
        ],
        child: WillPopScope (
              onWillPop: () async => false,
                  child: Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
            appBar: headerNav(_drawerKey),
            // bottomNavigationBar: bottomNav(),
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
                              Text('Product'),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.purple[800]),
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
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.purple[800]),
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
                        ColoredIconNumberRow('total_sales', 'Amount Sold'),
                        // ColoredIconNumberRow('open_sales_orders', 'Open Orders'),
                        ColoredIconNumberRow('amt_sales_return', 'Sales Return'),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        // ColoredIconNumberRow('qty_sales_order', 'Ordered Qty'),
                        // ColoredIconNumberRow('qty_sales_due', 'Quantity Due'),
                        ColoredIconNumberRow('open_sales_orders', 'Open Orders'),                
                        ColoredIconNumberRow('sales_discount', 'Discount'),
                      ],
                    )
                  ],
                ),
                // FilterBar('Sales Vouchers By', 'Due Date'),
                GoToBar('Sales Vouchers', VouchersHome()),
                // SalesVoucherList(),

                SecondarySectionHeader('Inactive Customer List'),

                InactiveCustomerList()


              ],
            ),
          ),
        ));
  }
}
