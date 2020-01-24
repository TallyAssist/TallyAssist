import 'package:flutter/material.dart';
import 'root_page.dart';
import 'authentication.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(
              image: AssetImage('graphics/dataanalysis.png'),
              fit: BoxFit.fill,
            ),
            Positioned(
              right: 10,
              left: 10,
              bottom: 30,
              child: HomeScreenButton(),
            ),
          ],
        ),
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
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RootPage(
                      auth: new Auth(),
                    ),
                  ),
                );
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                color: Colors.purple,
                padding: const EdgeInsets.all(10.0),
                child: const Text('Start Now!', style: TextStyle(fontSize: 20)),
              ),
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
    return Column(
      children: <Widget>[
        Text(
          "BizAssist",
          style: TextStyle(
              color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 40),
        ),
        const SizedBox(height: 10),
        Text(
          "Your own business assistant",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'authentication.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key, this.auth, this.userId, this.onSignedOut})
//       : super(key: key);
//   final BaseAuth auth;
//   final VoidCallback onSignedOut;
//   final String userId;
//   @override
//   State<StatefulWidget> createState() => new _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   _signOut() async {
//     try {
//       await widget.auth.signOut();
//       widget.onSignedOut();
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text('Flutter login demo'),
//         actions: <Widget>[
//           new FlatButton(
//               child: new Text('Logout',
//                   style: new TextStyle(fontSize: 17.0, color: Colors.white)),
//               onPressed: _signOut)
//         ],
//       ),
//       body: Center(
//         child: Text("hello"),
//       ),
//     );
//   }
// }
