// Pending issue - dropdown widget not displaying value

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/core/services/timeperiod_filter_service.dart';
import 'package:tassist/theme/theme.dart';
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
import 'package:tassist/ui/widgets/myboxdecoration.dart';

class HomeDashboardScreen extends StatefulWidget {
  HomeDashboardScreen({Key key, this.userId}) : super(key: key);

  final String userId;

  @override
  _HomeDashboardScreenState createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  String timePeriod = 'Everything';

   bool tallyconnected = false;

  tallyconnection(bool successConnection) {
    
  if (successConnection == true) {
    return  Container(
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
                  );
  }
  else {
   return  Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 1.0, 10.0, 1.0),
                      child: Text(
                        'Your Tally is not connected :(',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    color: TassistWarning,
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                  );
                  }
}




  
 
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
                  tallyconnection(tallyconnected),
                  // Container 0 - Timeperiod picker
                  Container(
                    decoration: myBoxDecorationBottomBorder(),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(4.0, 2.0, 10.0, 2.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Select timeperiod ->",
                            style: secondaryListDisc.copyWith(color: TassistPrimary),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(Icons.access_time, color: TassistPrimary),
                            onSelected: (value) {
                              setState(() {
                                timePeriod = value;
                              });
                            },
                            itemBuilder: (BuildContext context) {
                              return timePeriodList.map(
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
                          Text(timePeriod)
                        ],
                      ),
                    ),
                    // color: Colors.blueGrey[100],
                    width: MediaQuery.of(context).size.width,
                    height: 35,
                  ),
                  // Container 1 - Sales
                  Container(
                    child: SalesDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(15.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Check Sales', SalesOrderReportScreen()),
                  // Container 2 - Purchases
                  Container(
                    child: ReceiptsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Check Receipts', VouchersHome()),
                  Container(
                    child: PurchasesDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Check Purchases', PurchaseOrderReportScreen()),
                  Container(
                    child: PaymentsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(20.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                  GoToBar('Check Payments', VouchersHome()),
                  Container(
                    child: OutstandingsDashboardWidget(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(15.0),
                    // decoration: myBoxDecorationTopBorder()
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

