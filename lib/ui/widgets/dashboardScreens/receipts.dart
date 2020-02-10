import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tassist/theme/colors.dart';

class ReceiptsDashboardWidget extends StatefulWidget {
  @override
  _ReceiptsDashboardWidgetState createState() =>
      _ReceiptsDashboardWidgetState();
}

class _ReceiptsDashboardWidgetState extends State<ReceiptsDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: ReceiptsDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          ReceiptsDashboardWidgetContentRow(),
        ],
      ),
    );
  }
}

class ReceiptsDashboardWidgetContentRow extends StatefulWidget {
  @override
  _ReceiptsDashboardWidgetContentRowState createState() =>
      _ReceiptsDashboardWidgetContentRowState();
}

class _ReceiptsDashboardWidgetContentRowState
    extends State<ReceiptsDashboardWidgetContentRow> {
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument = snapshot.data;

    return FittedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Icon(
                  //   Icons.arrow_drop_up,
                  //   color: TassistInfoGrey,
                  // ),
                  Text(
                    userDocument['total_receipts'].toString() ?? '',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: TassistMainText,
                        fontSize: 24,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
              Text('Total Receipts'),
            ],
          ),
          SizedBox(
            width: 100.0,
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  // Icon(
                  //   Icons.arrow_drop_down,
                  //   color: TassistMainText,
                  // ),
                  Text(
                    userDocument['num_receipts_vouchers'].toString() ?? '',
                    style: TextStyle(
                      color: TassistMainText,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Vouchers'),
            ],
          ),
          // SimpleTimeSeriesChart.withSampleData(),
        ],
      ),
    );
  }
}

class ReceiptsDashboardWidgetTitleRow extends StatelessWidget {
  const ReceiptsDashboardWidgetTitleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument = snapshot.data;

    void shareReceipts(BuildContext context, double receipts) {
      final String text =
          "Total Receipts is ${userDocument['total_receipts'].toString()}, and total number of vouchers ${userDocument['num_receipts_vouchers'].toString()}. - Shared via restat.co/tallyassist.in";

      Share.share(text,
          subject:
              "Total Receipts ${userDocument['total_receipts'].toString()}");
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Receipts',
                style: TextStyle(
                    color: TassistPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              SizedBox(width: 5.0),
              IconButton(
                icon: Icon(Icons.info_outline),
                color: Colors.grey[400],
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Total Receipts'),
                      content: Text(
                          'Total Receipts is calculated using sum of Sales Vouchers. This represents all receipts.'),
                      elevation: 24.0,
                      actions: <Widget>[
                        FlatButton(
                            child: Text('Ok'),
                            onPressed: () => Navigator.of(context).pop())
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              // Icon(
              //   Icons.favorite,
              //   color: TassistPrimaryBackground,
              // ),
              // Icon(
              //   Icons.bookmark,
              //   color: TassistPrimaryBackground,
              // ),
              IconButton(
                icon: Icon(Icons.share),
                color: TassistPrimaryBackground,
                onPressed: () =>
                    shareReceipts(context, userDocument['total_receipts']),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
