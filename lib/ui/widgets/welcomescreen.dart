import 'package:flutter/material.dart';

import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/views/dashboard.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}


class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), (){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context) => DashboardScreen())
    );

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
              Center(child: Text('Welcome to TallyAssist', style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: 24.0,
                  color: TassistWhite
                ),))
              
            ],
          ),
        ),
      ),
    );
  }
}

