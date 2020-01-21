import 'package:flutter/material.dart';
import './headernav.dart';
import './bottomnav.dart';
import './detailcard.dart';

class ProductPerformanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(context),
      bottomNavigationBar: bottomNav(),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '14% profit')
            ],
          ) 
        ],
      ),
    );
  }
}
