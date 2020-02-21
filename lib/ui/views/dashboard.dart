// Pending issue - dropdown widget not displaying value

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';
// import 'package:tassist/theme/colors.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/views/accountspayablescreen.dart';
import 'package:tassist/ui/views/accountsreceivables.dart';
import 'package:tassist/ui/views/pruchaseorderreport.dart';
import 'package:tassist/ui/views/salesorderreport.dart';
import 'package:tassist/ui/views/vouchers.dart';
import 'package:tassist/ui/widgets/dashboardScreens/Purchases.dart';
// import 'package:tassist/ui/widgets/dashboardScreens/expenses.dart';
import 'package:tassist/ui/widgets/dashboardScreens/payments.dart';
import 'package:tassist/ui/widgets/dashboardScreens/receipts.dart';
import 'package:tassist/ui/widgets/dashboardScreens/sales.dart';
import 'package:tassist/ui/widgets/gotobar.dart';
// import 'package:tassist/ui/widgets/dashboardScreens/cash.dart';
import 'package:tassist/ui/widgets/dashboardScreens/outstanding.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.userId}) : super(key: key);

  final String userId;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String timePeriod = 'Everything';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    print(timePeriod);

    return MultiProvider(
        providers: [
          StreamProvider<DocumentSnapshot>.value(
              value: DatabaseService()
                  .metricCollection
                  .document(user?.uid)
                  .snapshots()),
        ],
        child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: _drawerKey,
            appBar: headerNav(_drawerKey),
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
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    color: const Color(0xff14D2B8),
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                  ),
                  // Container 0 - Timeperiod picker
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 1.0, 10.0, 1.0),
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          setState(() {
                            timePeriod = value;
                          });
                        },
                        itemBuilder: (BuildContext context) {
                          return <String>['Everything', 'FY 2017-18'].map(
                            (String choice) {
                              return PopupMenuItem<String>(
                                value: choice,
                                child: Text(
                                  choice,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14.0),
                                ),
                              );
                            },
                          ).toList();
                        },
                      ),
                    ),
                    color: Colors.blueGrey[100],
                    width: MediaQuery.of(context).size.width,
                    height: 30,
                  ),
                  // Container 1 - Sales
                  Container(
                    child: SalesDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(15.0),
                    // decoration: myBoxDecoration()
                  ),
                  GoToBar('Check Sales', SalesOrderReportScreen()),
                  // Container 2 - Purchases
                  Container(
                    child: ReceiptsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecoration()
                  ),
                  GoToBar('Check Receipts', VouchersHome()),
                  Container(
                    child: PurchasesDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecoration()
                  ),
                  GoToBar('Check Purchases', PurchaseOrderReportScreen()),
                  Container(
                    child: PaymentsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecoration()
                  ),
                  GoToBar('Check Payments', VouchersHome()),
                  // Column(
                  //   children: <Widget>[
                  //     Text(
                  //       'Coming soon...',
                  //       style: TextStyle(
                  //         backgroundColor: TassistWarning,
                  //         color: TassistWhite,
                  //         fontSize: 24.0,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // Container(
                  //   child: ExpenseDashboardWidget(),
                  //   margin: const EdgeInsets.all(15.0),
                  //   // decoration: myBoxDecoration()
                  // ),
                  // GoToBar('Check Expenses', DashboardScreen()),
                  // Container(
                  //   child: CashWidget(),
                  //   margin: const EdgeInsets.all(15.0),
                  // ),
                  // GoToBar('Check Bank Reconciliation', DashboardScreen()),
                  Container(
                    child: OutstandingsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(15.0),
                    // decoration: myBoxDecoration()
                  ),
                  GoToBar('Accounts Payables', AccountsPayableScreen()),
                  GoToBar('Accounts Receivables', AccountsReceivableScreen())
                ],
              ),
            ),
          ),
        ));
  }
}
