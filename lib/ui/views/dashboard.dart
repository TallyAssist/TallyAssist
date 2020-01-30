// Pending issue - dropdown widget not displaying value

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/shared/bottomnav.dart';
import 'package:tassist/ui/widgets/dashboardScreens/Purchases.dart';
import 'package:tassist/ui/widgets/dashboardScreens/expenses.dart';
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


    return  MultiProvider(

        providers: [ 
          StreamProvider<DocumentSnapshot>.value (value: DatabaseService().metricCollection.document(user.uid).snapshots()),
    ],
        child:Scaffold(
        appBar: headerNav(context),
        body: ListView(
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
            GoToBar('Pending Sales Orders'),
            // Container 2 - Purchases
            Container(
              child: PurchaseDashboardWidget(),
              margin: const EdgeInsets.all(20.0),
              // decoration: myBoxDecoration()
            ),
            GoToBar('Check Pending Purchase Orders'),
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
        bottomNavigationBar: bottomNav(),
    )
    );
  }
}

