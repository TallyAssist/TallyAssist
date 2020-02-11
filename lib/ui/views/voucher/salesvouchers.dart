import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/salesvoucher.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/ui/widgets/salesvoucherslist.dart';

class SalesVoucherScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

  final user = Provider.of<FirebaseUser>(context);

    return ListView(
    children: <Widget>[
    SalesVoucherList()

  ],
);
  }
}