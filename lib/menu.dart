import 'package:flutter/material.dart';
import 'package:tassist/accountsreceivables.dart';
import 'package:tassist/gstreportscreen.dart';
import 'package:tassist/pruchaseorderreport.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import './dashboard.dart';
import './salesorderreport.dart';
import './notifications.dart';
import './productperformance.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TassistMenuBg,
        title: Text(
          'Menu',
          style: TextStyle(
            letterSpacing: 1.0,
          ),
        ),
      ),
      backgroundColor: TassistMenuBg,
      body: ListView(
  
        children: <Widget>[
          const SizedBox(
            height:15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.sm,
                    child: Icon(Icons.mail_outline, color: Colors.white,),
                  ),
                  Text(
                    'Notifications',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.title.copyWith(
                      color: TassistWhite
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => NotificationScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.sm,
                    child: Icon(Icons.dashboard, color: Colors.white,),
                  ),
                  Text(
                    'Dashboard',
                    textAlign: TextAlign.center,
                   style: Theme.of(context).textTheme.title.copyWith(
                      color: TassistWhite
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.sm,
                    child: Icon(Icons.domain, color: Colors.white,),
                  ),
                  Text(
                    'Product Performance',
                    textAlign: TextAlign.center,
                   style: Theme.of(context).textTheme.title.copyWith(
                      color: TassistWhite
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => (ProductPerformanceScreen()),
                  ),
                );
              },
            ),
          ),
           const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.sm,
                    child: Icon(Icons.card_giftcard, color: Colors.white,),
                  ),
                  Text(
                    'Sales',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title.copyWith(
                      color: TassistWhite
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SalesOrderReportScreen(),
                  ),
                );
              },
            ),
          ),
           const SizedBox(
            height: 15,
          ),
         Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.sm,
                    child: Icon(Icons.card_membership, color: Colors.white,),
                  ),
                  Text(
                    'Purchases',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title.copyWith(
                      color: TassistWhite
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => PurchaseOrderReportScreen(),
                  ),
                );
              },
            ),
          ),
         const SizedBox(
           height: 15,
         ),
         Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.sm,
                    child: Icon(Icons.card_membership, color: Colors.white,),
                  ),
                  Text(
                    'Accounts Receivables',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title.copyWith(
                      color: TassistWhite
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => AccountsReceivableScreen(),
                  ),
                );
              },
            ),
          ),
        
        const SizedBox(
           height: 15,
         ),
         Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.sm,
                    child: Icon(Icons.card_membership, color: Colors.white,),
                  ),
                  Text(
                    'GST Report',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.title.copyWith(
                      color: TassistWhite
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => GstReportScreen(),
                  ),
                );
              },
            ),
          ),
        
        ],
      ),
    );
  }
}
