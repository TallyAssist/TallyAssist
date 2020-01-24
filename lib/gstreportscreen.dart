import 'package:flutter/material.dart';
import 'package:tassist/gotobar.dart';
import 'package:tassist/gstcard.dart';
import './headernav.dart';
import './bottomnav.dart';
import './sectionHeader.dart';



class GstReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(context),
      bottomNavigationBar: bottomNav(),
      body: ListView(
        children: <Widget>[
          SectionHeader('GST Report'),
          GSTCard('IGST', 'Input',  'Rs. 12,13,234', 'Output', 'Rs. 12,11,234', 'Net Payable', 'Rs. 12,345'),
          GoToBar('Due IGST From/To'),
          GSTCard('CGST', 'Input',  'Rs. 12,13,234', 'Output', 'Rs. 12,11,234', 'Net Payable', 'Rs. 12,345'),
           GoToBar('Due CGST From/To'),
          GSTCard('SGST', 'Input',  'Rs. 12,13,234', 'Output', 'Rs. 12,11,234', 'Net Payable', 'Rs. 12,345'),
           GoToBar('Due SGST From/To'),
          GSTCard('Total GST', 'Input',  'Rs. 12,13,234', 'Output', 'Rs. 12,11,234', 'Net Payable', 'Rs. 12,345'),
          GoToBar('Due GST From/To'),

        ]
      )
    );
  }
}
