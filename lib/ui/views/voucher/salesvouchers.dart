import 'package:flutter/material.dart';
import 'package:tassist/ui/widgets/salesvoucherslist.dart';

class SalesVoucherScreen extends StatelessWidget {
  final String timePeriod;
  SalesVoucherScreen({this.timePeriod});

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<FirebaseUser>(context);

    return ListView(
      children: <Widget>[
        SalesVoucherList(
          timePeriod: timePeriod,
        )
      ],
    );
  }
}
