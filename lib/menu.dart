import 'package:flutter/material.dart';
import './dashboard.dart';

class MenuScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[300],
        title: Text('Menu'),
      ),
      backgroundColor: Colors.purple[300],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30,),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.mail),
                Text(
                  'Notifications',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // onTap: () {

            // },
          ),
          const SizedBox(height: 30,),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.mail),
                Text(
                  'Dashboard',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => DashboardScreen(),
              ),);              
            },
          ),
          ],
      ),
    );
  }
}
