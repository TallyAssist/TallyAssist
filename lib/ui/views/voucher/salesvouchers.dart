
import 'package:flutter/material.dart';
import 'package:tassist/ui/widgets/salesvoucherslist.dart';

class SalesVoucherScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

  // final user = Provider.of<FirebaseUser>(context);

    return ListView(
    children: <Widget>[
    SalesVoucherList()

  ],
);
  }
}