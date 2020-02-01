import 'package:flutter/material.dart';
import 'package:tassist/ui/shared/bottomnav.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:tassist/ui/widgets/secondarysectionheader.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';

class ProductPerformanceScreen extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
        final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _drawerKey,
      appBar: headerNav(_drawerKey),
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
