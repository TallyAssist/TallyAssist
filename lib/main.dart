import 'package:flutter/material.dart';
import './homescreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = "BizAssist";

    return MaterialApp(
      title: _title,
      home: HomeScreen(),
    );
  }
}
