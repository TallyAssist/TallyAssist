// Pending issue - dropdown widget not displaying value

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';

import 'package:tassist/ui/widgets/dashboardScreens/Purchases.dart';
import 'package:tassist/ui/widgets/dashboardScreens/expenses.dart';
import 'package:tassist/ui/widgets/dashboardScreens/payments.dart';
import 'package:tassist/ui/widgets/dashboardScreens/receipts.dart';
import 'package:tassist/ui/widgets/dashboardScreens/sales.dart';
import 'package:tassist/ui/widgets/gotobar.dart';
import 'package:tassist/ui/widgets/dashboardScreens/cash.dart';
import 'package:tassist/ui/widgets/dashboardScreens/outstanding.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.userId}) : super(key: key);

  final String userId;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return MultiProvider(
        providers: [
          StreamProvider<DocumentSnapshot>.value(
              value: DatabaseService()
                  .metricCollection
                  .document(user.uid)
                  .snapshots()),
        ],
        child: Scaffold(
          key: _drawerKey,
          appBar: headerNav(_drawerKey),
          // appBar: AppBar(
          //     leading: Padding(
          //       padding: EdgeInsets.only(left: 12),
          //       child: IconButton(
          //         icon: Icon(Icons.menu),
          //         onPressed: () {
          //           // Navigator.of(context).pushReplacement(
          //           //   MaterialPageRoute(
          //           //     builder: (context) => MenuScreen(),
          //           //   ),
          //           // // );
          //           if (enabled) {
          //           //   // open drawer if this value is true
          //             _drawerKey.currentState.openDrawer();
          //           }
          //         },
          //       ),
          //     ),
          //     title: Row(
          //       children: <Widget>[
          //         Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: <Widget>[
          //             const Text(
          //               'ABC Pvt Ltd',
          //               style: TextStyle(
          //                 fontSize: 15,
          //                 fontWeight: FontWeight.bold,
          //                 letterSpacing: 1.0,
          //               ),
          //             ),
          //             const Text(
          //               'GSTIN: 29ABCDE1234F2Z5',
          //               style: TextStyle(
          //                 color: TassistWhite,
          //                 fontSize: 12,
          //                 letterSpacing: 1.0,
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           width: 10.0,
          //         ),
          //         DropDownMonths(),
          //       ],
          //     ),
          //     backgroundColor: TassistMenuBg),
          drawer: tassistDrawer(context),
          body: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 1.0, 10.0, 1.0),
                    child: Text(
                      'Your Tally is Connected!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  color: const Color(0xff14D2B8),
                  width: MediaQuery.of(context).size.width,
                  height: 20,
                ),
                // Container 1 - Sales
                Container(
                  child: SalesDashboardWidget(),
                  margin: const EdgeInsets.all(15.0),
                  // decoration: myBoxDecoration()
                ),
                GoToBar('Check Sales'),
                // Container 2 - Purchases
                Container(
                  child: ReceiptsDashboardWidget(),
                  margin: const EdgeInsets.all(20.0),
                  // decoration: myBoxDecoration()
                ),
                GoToBar('Check Receipts'),
                Container(
                  child: PurchasesDashboardWidget(),
                  margin: const EdgeInsets.all(20.0),
                  // decoration: myBoxDecoration()
                ),
                GoToBar('Check Purchases'),
                Container(
                  child: PaymentsDashboardWidget(),
                  margin: const EdgeInsets.all(20.0),
                  // decoration: myBoxDecoration()
                ),
                GoToBar('Check Payments'),
                Column(
                  children: <Widget>[
                    Text(
                      'Coming soon...',
                      style: TextStyle(
                        backgroundColor: TassistWarning,
                        color: TassistWhite,
                        fontSize: 24.0,
                      ),
                    )
                  ],
                ),
                Container(
                  child: ExpenseDashboardWidget(),
                  margin: const EdgeInsets.all(15.0),
                  // decoration: myBoxDecoration()
                ),
                GoToBar('Check Expenses'),
                Container(
                  child: CashWidget(),
                  margin: const EdgeInsets.all(15.0),
                ),
                GoToBar('Check Bank Reconciliation'),
                Container(
                  child: OutstandingsDashboardWidget(),
                  margin: const EdgeInsets.all(15.0),
                  // decoration: myBoxDecoration()
                ),
                GoToBar('Accounts Payables'),
                GoToBar('Accounts Receivables')
              ],
            ),
          ),
          // bottomNavigationBar: bottomNav(),
        ));
  }
}
