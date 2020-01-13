import 'package:flutter/material.dart';
import './login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Image(
            image: AssetImage('graphics/rumi-gate.jpg'),
          ),
          Center(
            child: HomeScreenButton(),
          ),
        ],
      ),
    );
  }
}

class HomeScreenButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          HomeScreenText(),
          const SizedBox(height: 30),
          RaisedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Text('Start Now!', style: TextStyle(fontSize: 20)),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeScreenText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "BizAssist",
      style: TextStyle(
          color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 40),
    );
  }
}
