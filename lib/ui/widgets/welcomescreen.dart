import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/views/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: TassistPrimary,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Image(
              //   image: AssetImage('graphics/dataanalysis.png'),
              //   fit: BoxFit.fill,
              // ),
              Padding(
                padding: spacer.all.md,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     Text(
                  'Welcome to TallyAssist!',
                  style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 24.0, color: TassistWhite),
                ),
                SizedBox(height: 50),
                Text(
                  'Have you installed the Tally Connector yet?',
                  style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontSize: 20.0, color: TassistWhite),
                ),
                SizedBox(height: 30),
                 RaisedButton( 
                   color: TassistWhite,
                   child:
                   Row(children: <Widget>[
                  Icon(FontAwesomeIcons.laptop),
                  SizedBox(width: 30),
                  Text('Launch the Tally Connector website')

                   ]),
                onPressed: () => _launchURL(),)
       

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


_launchURL() async {
  const url = 'https://restat.co/tallyassist/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
