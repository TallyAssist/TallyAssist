import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tassist/theme/colors.dart';

class SalesDashboardWidget extends StatefulWidget {
  final String timePeriod;
  SalesDashboardWidget({this.timePeriod});

  @override
  _SalesDashboardWidgetState createState() => _SalesDashboardWidgetState();
}

class _SalesDashboardWidgetState extends State<SalesDashboardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: SalesDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          SalesDashboardWidgetContentRow(timePeriod: widget.timePeriod),
        ],
      ),
    );
  }
}

class SalesDashboardWidgetContentRow extends StatefulWidget {
  final String timePeriod;
  SalesDashboardWidgetContentRow({this.timePeriod});

  @override
  _SalesDashboardWidgetContentRowState createState() =>
      _SalesDashboardWidgetContentRowState();
}

class _SalesDashboardWidgetContentRowState
    extends State<SalesDashboardWidgetContentRow> {
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument;
    if (widget.timePeriod == 'Everything') {
      userDocument = snapshot?.data;
    } else {
      userDocument = snapshot?.data[widget.timePeriod];
    }

    if (snapshot?.data != null) {
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
                      userDocument['total_sales'].toString() ?? '',
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: TassistMainText,
                          fontSize: 24,
                          fontWeight: FontWeight.normal),
                    )
                  ],
                ),
                Text('Total Sales'),
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
                      userDocument['num_sales_vouchers'].toString() ?? '',
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
    } else {
      return Container(
        child: Center(
          child: Text('Loading...'),
        ),
      );
    }
  }
}

class SalesDashboardWidgetTitleRow extends StatelessWidget {
  const SalesDashboardWidgetTitleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DocumentSnapshot>(context);
    var userDocument = snapshot?.data;

    void shareSales(BuildContext context, double sales) {
      final String text =
          "Total Sales is ${userDocument['total_sales'].toString()}, and total number of vouchers ${userDocument['num_sales_vouchers']}. - Shared via restat.co/tallyassist.in";

      Share.share(text,
          subject: "Total Sales ${userDocument['total_sales'].toString()}");
    }

    if (snapshot?.data != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Text(
                  'Sales',
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
                        title: Text('Total Sales'),
                        content: Text(
                          'Total Sales is calculated using sum of Sales Vouchers. This represents Gross Sales.',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
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
                      shareSales(context, userDocument['total_sales']),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container(
        child: Center(
          child: Text('Loading...'),
        ),
      );
    }
  }
}
