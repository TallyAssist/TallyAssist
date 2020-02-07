import 'package:flutter/material.dart';

import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/widgets/gotobar.dart';
import 'package:tassist/ui/widgets/gstcard.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';


class GstReportScreen extends StatelessWidget {

      final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: tassistDrawer(context),
      appBar: headerNav(_drawerKey),
      // bottomNavigationBar: bottomNav(),
      body: ListView(
        children: <Widget>[
          SectionHeader('GST Report'),
          GSTCard('IGST', 'Input',  'Rs. 12,13,234', 'Output', 'Rs. 12,11,234', 'Net Payable', 'Rs. 12,345'),
          GoToBar('Due IGST From/To', GstReportScreen()),
          GSTCard('CGST', 'Input',  'Rs. 12,13,234', 'Output', 'Rs. 12,11,234', 'Net Payable', 'Rs. 12,345'),
           GoToBar('Due CGST From/To', GstReportScreen()),
          GSTCard('SGST', 'Input',  'Rs. 12,13,234', 'Output', 'Rs. 12,11,234', 'Net Payable', 'Rs. 12,345'),
           GoToBar('Due SGST From/To', GstReportScreen()),
          GSTCard('Total GST', 'Input',  'Rs. 12,13,234', 'Output', 'Rs. 12,11,234', 'Net Payable', 'Rs. 12,345'),
          GoToBar('Due GST From/To', GstReportScreen()),

        ]
      )
    );
  }
}
