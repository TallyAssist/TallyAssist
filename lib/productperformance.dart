import 'package:flutter/material.dart';
import 'package:tassist/secondarysectionheader.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import './headernav.dart';
import './bottomnav.dart';
import './detailcard.dart';
import './sectionHeader.dart';

class ProductPerformanceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(context),
      bottomNavigationBar: bottomNav(),
      body: ListView(
        children: <Widget>[
          SectionHeader('Product Performance'),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '14% profit'),
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '14% profit'),
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '14% profit'),
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '14% profit'),
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '14% profit'),
            ],
          ),
         SecondarySectionHeader('Inactive Items'),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '1-10-2019'),
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '1-10-2019'),
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '1-10-2019'),
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '1-10-2019'),
            DetailCard('Product 1', '225 Nos.', '3 days', '1,23,890', '1-10-2019'),
            ],
          ),
        ],
      ),
    );
  }
}
