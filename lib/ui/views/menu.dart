import 'package:flutter/material.dart';
import 'package:tassist/authentication.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/views/accountsreceivables.dart';
import 'package:tassist/ui/views/gstreportscreen.dart';
import 'package:tassist/ui/views/pruchaseorderreport.dart';
import './dashboard.dart';
import './salesorderreport.dart';
import './notifications.dart';
import './productperformance.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key key, this.auth, this.userId, this.onSignedOut})
      : super(key: key);
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId;

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
    } catch (e) {
      print(e);
    }
  }

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
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.sm,
                    child: Icon(
                      Icons.mail_outline,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Notifications',
                    textAlign: TextAlign.left,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: TassistWhite),
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
          SizedBox(
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
                    child: Icon(
                      Icons.dashboard,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Dashboard',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: TassistWhite),
                  ),
                ],
              ),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => DashboardScreen(
                      userId: widget.userId,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
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
                    child: Icon(
                      Icons.domain,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Product Performance',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: TassistWhite),
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
                    child: Icon(
                      Icons.card_giftcard,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Sales',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: TassistWhite),
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
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.card_giftcard,
                    color: Colors.white,
                  ),
                  Text(
                    'Sign Out',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ],
              ),
              onTap: () {
                _signOut();
              },
            ),
          ),
          SizedBox(
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
                    child: Icon(
                      Icons.card_membership,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Purchases',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: TassistWhite),
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
                    child: Icon(
                      Icons.card_membership,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Accounts Receivables',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: TassistWhite),
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
                    child: Icon(
                      Icons.card_membership,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'GST Report',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(color: TassistWhite),
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
