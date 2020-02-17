import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/core/services/ledgerservice.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/coloredIcon.dart';
import 'package:tassist/ui/widgets/detailcard.dart';

class LedgerSummary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    LedgerItem ledgerItem;
    // final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

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
                      child: SingleChildScrollView(
                                              child: Column(
                          children: <Widget> [
                            Padding(
                                padding: spacer.all.xxs,
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                Text('Shyam Lal & Sons'),
                                Text('GSTIN123208DDSP'),
                                Icon(FontAwesomeIcons.whatsapp)
                               
                              ],),
                            ),
                             Container(
                                height: 3.0,
                                color: TassistPrimary
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  elevation: 5.0,
                                  child: Column(
                                    children: <Widget>[
                                                                    Padding(
                                      padding: spacer.all.xxs,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('Receivables'),
                                          Text('Rs. 12,10,100')
                                        ],
                                      ),
                                    ),
                                

                                  Padding(
                                    padding: spacer.all.xxs,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Payables'),
                                        Text('Rs. 12,10,100')
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: spacer.all.xxs,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Closing Balance'),
                                        Text('Rs. 12,10,100')
                                      ],
                                    ),
                                  ),
                                  
                                  Padding(
                                    padding: spacer.all.xxs,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Opening Balance'),
                                        Text('Rs. 12,10,100')
                                      ],
                                    ),
                                  ),
                                      ],
                                        ),
                                ),
                              ),
                              LedgerMetric(title: 'Sales', number: 'Invoices: 24', date: 'Last: 24/07/2019', metric: 'Total: Rs. 4,21,201', average: 'Average: 21,000'),
                              LedgerMetric(title: 'Receipts', number: 'Invoices: 24', date: 'Last: 24/07/2019', metric: 'Total: Rs. 4,21,201', average: 'Average: 21,000'),
                              LedgerMetric(title: 'Purchases', number: 'Invoices: 24', date: 'Last: 24/07/2019', metric: 'Total: Rs. 4,21,201', average: 'Average: 21,000'),
                              LedgerMetric(title: 'Payment', number: 'Invoices: 24', date: 'Last: 24/07/2019', metric: 'Total: Rs. 4,21,201', average: 'Average: 21,000'),
                              
                          ]
                        ),
                      )
        ));
  }
}

class LedgerMetric extends StatelessWidget {

  final String title;
  final String metric;
  final String date;
  final String number;
  final String average;

   LedgerMetric({this.title, this.number, this.date, this.metric, this.average});
   

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DetailCard(title, number, date, metric, average)
    );
  }
}
