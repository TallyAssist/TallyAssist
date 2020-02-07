
import 'package:flutter/material.dart';
import 'package:tassist/ui/shared/metricswidget.dart';

  class CashWidget extends StatefulWidget {
    @override
    _CashWidgetState createState() => _CashWidgetState();
  }
  
  class _CashWidgetState extends State<CashWidget> {
    @override
    Widget build(BuildContext context) {
  
 

  return Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                  MetricsWidget(metricsWidgetTitle: 'Cash In Hand', metricsWidget: 'cash_in_hand',)
                  ]
                ),  
                Column(
                  children: <Widget>[
                   MetricsWidget(metricsWidgetTitle: 'Cash In Bank', metricsWidget: 'cash_in_bank',)
                  ],
                )
              ],
            ),
  );

    }
  }