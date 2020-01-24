import 'package:flutter/material.dart';
import 'package:tassist/authentication.dart';
import './dashboard.dart';
import './salesorderreport.dart';
import './notifications.dart';

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
        backgroundColor: Colors.purple[300],
        title: Text(
          'Menu',
          style: TextStyle(
            letterSpacing: 1.0,
          ),
        ),
      ),
      backgroundColor: Colors.purple[300],
      body: ListView(
        children: <Widget>[
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
                    Icons.mail_outline,
                    color: Colors.white,
                  ),
                  Text(
                    'Notifications',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
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
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.dashboard,
                    color: Colors.white,
                  ),
                  Text(
                    'Dashboard',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
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
                    'Sales',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
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
        ],
      ),
    );
  }
}
