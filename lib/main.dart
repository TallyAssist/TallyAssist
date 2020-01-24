import 'package:flutter/material.dart';
import 'package:tassist/theme/texts.dart';
import './homescreen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = "BizAssist";

    return MaterialApp(
      title: _title,
      home: HomeScreen(),
      // home: RootPage(
      //   auth: new Auth(),
      // ),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          textTheme: TextTheme(title: primaryAppBarTitle),
        ),
        textTheme: TextTheme(
          title: secondaryListTitle,
          body1: secondaryListDisc,
          body2: secondaryListTitle2
        )
      ),
    );
  }
}