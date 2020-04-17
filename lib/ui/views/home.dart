// Pending issue - dropdown widget not displaying value

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/core/services/database.dart';
// import 'package:tassist/core/services/timeperiod_filter_service.dart';
import 'package:tassist/theme/theme.dart';
// import 'package:tassist/theme/colors.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/views/accountspayablescreen.dart';
import 'package:tassist/ui/views/accountsreceivables.dart';
import 'package:tassist/ui/views/customerinput.dart';
import 'package:tassist/ui/views/productinput.dart';
import 'package:tassist/ui/views/ledgerinput.dart';
import 'package:tassist/ui/views/ledgerscreen.dart';
import 'package:tassist/ui/views/settingsscreen.dart';
import 'package:tassist/ui/views/stockscreen.dart';
import 'package:tassist/ui/views/vouchers.dart';
import 'package:tassist/core/services/string_format.dart';

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
          // //   bottomNavigationBar:
          // //   FloatingActionButton(
          // //     child: Icon(FontAwesomeIcons.fileInvoice),
          // //     backgroundColor: TassistPrimaryDarkButtonShadow,
          // //     onPressed:  () {Navigator.of(context).pushReplacement(
          // //     MaterialPageRoute(
          // //             builder: (context) => LedgerInputScreen()
          // //           )
          // // );
          // //       })
          //   ,
            body: SafeArea(
              child: ListView(
                children: <Widget>[
                  tallyconnection(tallyconnected),
                  // Container 0 - Timeperiod picker
                  // Container(
                  //   decoration: myBoxDecorationBottomBorder(),
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(4.0, 1.0, 10.0, 1.0),
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.end,
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: <Widget>[
                  //         Text(
                  //           "Select timeperiod -> ",
                  //           style: secondaryListDisc.copyWith(color: TassistPrimary),
                  //         ),
                  //         PopupMenuButton<String>(
                  //           icon: Icon(Icons.access_time, color: TassistPrimary),
                  //           onSelected: (value) {
                  //             setState(() {
                  //               timePeriod = value;
                  //             });
                  //           },
                  //           itemBuilder: (BuildContext context) {
                  //             return timePeriodList.map(
                  //               (String choice) {
                  //                 return PopupMenuItem<String>(
                  //                   value: choice,
                  //                   child: Text(
                  //                     choice,
                  //                     style: TextStyle(
                  //                         fontWeight: FontWeight.normal,
                  //                         fontSize: 14.0),
                  //                   ),
                  //                 );
                  //               },
                  //             ).toList();
                  //           },
                  //         ),
                  //         Text(timePeriod)
                  //       ],
                  //     ),
                  //   ),
                  //   // color: Colors.blueGrey[100],
                  //   width: MediaQuery.of(context).size.width,
                  //   height: 35,
                  // ),
                  // Container 1 - Sales
                  Container(
                    child: DashboardCard(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(15.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                   Container(
                    child: DashboardCard2(
                      timePeriod: timePeriod,
                    ),
                    margin: const EdgeInsets.all(15.0),
                    // decoration: myBoxDecorationTopBorder()
                  ),
                    Padding(
                      padding: spacer.all.xs,
                      child: Text('View', style: secondaryListTitle,),
                    ),
                    Padding(
                      padding: spacer.x.xs,
                      child: Row(
                        children: <Widget>[
                        ActionButton(Icon(FontAwesomeIcons.listAlt), LedgerScreen(), 'Parties'),
                        ActionButton(Icon(FontAwesomeIcons.fileInvoice), VouchersHome(), 'Vouchers'),
                        ActionButton(Icon(FontAwesomeIcons.warehouse), StockScreen(), 'Stock'),
                        ActionButton(Icon(Icons.settings), SettingsScreen(), 'Settings'),
                        ],
                      ),
                    ),
                     Padding(
                      padding: spacer.all.xs,
                      child: Text('Create', style: secondaryListTitle,),
                    ),
                    Padding(
                      padding: spacer.x.xs,
                      child: Row(
                        children: <Widget>[
                        ActionButton(Icon(FontAwesomeIcons.fileInvoice), LedgerInputScreen(), 'Invoice'),
                        ActionButton(Icon(FontAwesomeIcons.fileAlt), LedgerInputScreen(), 'Estimate'),
                        ActionButton(Icon(Icons.person_outline), CustomerInputScreen(), 'Party'),
                        ActionButton(Icon(Icons.add_shopping_cart), ProductInputScreen(), 'Product'),
                        ],
                      ),
                    )
                    
                                ],
              ),
            ),
          ),
        ));
  }
}
class DashboardCard extends StatefulWidget {
  final String timePeriod;
  DashboardCard({this.timePeriod});

  @override
  _DashboardCardState createState() =>
      _DashboardCardState();
}

class _DashboardCardState
    extends State<DashboardCard> {
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument;
    if (widget.timePeriod == 'Everything') {
      userDocument = snapshot?.data;
    } else {
      userDocument = snapshot?.data[widget.timePeriod];
    }

    if (userDocument != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         Card(
                elevation: 5,
                child:           
          Container(
            width: 170,
            height: 70,
            child: InkWell(
              onTap: () {Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                    builder: (context) => VouchersHome(),
                  )
        );
              },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
            
                        Text(
                            formatIndianCurrency(
                                    userDocument['total_sales'].toString()) ??
                                '',
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: TassistMainText,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                        ),
                
                  Text('Total Sales', style: secondaryListDisc.copyWith(color: TassistPrimary, fontSize: 14),),
                  
                ],
              ),
                          ),
            ),
          ),
            ),
          SizedBox(
            width: 20.0,
          ),
           Card(
                elevation: 5,
                child:           
          Container(
            width: 170,
            height: 70,
            child: InkWell(
              onTap: () {Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                    builder: (context) => VouchersHome(),
                  )
        );
              },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                    Text(
                      formatIndianCurrency(
                              userDocument['total_receipts'].toString()) ??
                          '',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: TassistMainText,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                Text('Total Receipts', style: secondaryListDisc.copyWith(color: TassistPrimary, fontSize: 14),),
              ],
            ),
                          )
            ),
          )
           )
          // SimpleTimeSeriesChart.withSampleData(),
       
       
        ],
      );
    } else {
      return Container(
        child: Center(
          child: Text('Loading...'),
        ),
      );
    }
  }
}

class DashboardCard2 extends StatefulWidget {
  final String timePeriod;
  DashboardCard2({this.timePeriod});

  @override
  _DashboardCard2State createState() =>
      _DashboardCard2State();
}

class _DashboardCard2State
    extends State<DashboardCard2> {
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument;
    if (widget.timePeriod == 'Everything') {
      userDocument = snapshot?.data;
    } else {
      userDocument = snapshot?.data[widget.timePeriod];
    }

    if (userDocument != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
         Card(
                elevation: 5,
                child:           
          Container(
            width: 170,
            height: 70,
            child: InkWell(
              onTap: () {Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                    builder: (context) => AccountsReceivableScreen(),
                  )
        );
              },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                
                        Text(
                            formatIndianCurrency(
                                    userDocument['out_actual_rec'].toString()) ??
                                '',
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: TassistMainText,
                                fontSize: 18,
                                fontWeight: FontWeight.normal),
                        ),
                
                  Text('Receivables', style: secondaryListDisc.copyWith(color: TassistPrimary, fontSize: 14),),
                  
                ],
              ),
                          ),
            ),
          ),
            ),
          SizedBox(
            width: 20.0,
          ),
           Card(
                elevation: 5,
                child:           
          Container(
            width: 170,
            height: 70,
            child: InkWell(
              onTap: () {Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                    builder: (context) => AccountsPayableScreen(),
                  )
        );
              },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
              
                    Text(
                      formatIndianCurrency(
                              userDocument['out_actual_pay'].toString()) ??
                          '',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: TassistMainText,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
               
                Text('Payables', style: secondaryListDisc.copyWith(color: TassistPrimary),),
              ],
            ),
                          )
            ),
          )
           )
          // SimpleTimeSeriesChart.withSampleData(),
       
       
        ],
      );
    } else {
      return Container(
        child: Center(
          child: Text('Loading...'),
        ),
      );
    }
  }
}




class ActionButton extends StatelessWidget {

final Icon icon;
final Widget widget;
final String title;
  
ActionButton(this.icon, this.widget, this.title);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
        width: 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget> [
        
            IconButton(icon: icon, 
            iconSize: 30,
            padding: const EdgeInsets.all(4.0),
            color: TassistInfoGrey,
            onPressed: () {Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                      builder: (context) => widget,
                    )
          );
                }),
              Text(title, style: secondaryListDisc.copyWith(fontSize: 12, color: TassistPrimary),)

          ]
        ),
      )
      
       
      
    );
  }
}

