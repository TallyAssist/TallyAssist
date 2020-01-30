import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/ui/views/homescreen.dart';
import 'package:tassist/ui/views/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);
    print(user);
    
    // return either the Home or Menu widget
    if (user == null){
      return HomeScreen();
    } else {
      return MenuScreen();
    }
    
  }
}
