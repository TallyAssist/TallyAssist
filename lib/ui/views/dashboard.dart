// Pending issue - dropdown widget not displaying value

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/shared/bottomnav.dart';

class SalesMetricText extends StatefulWidget {
  @override
  _SalesMetricTextState createState() => _SalesMetricTextState();
}

class _SalesMetricTextState extends State<SalesMetricText> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return new StreamBuilder(
        stream: Firestore.instance
            .collection('metrics')
            .document(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text(
              "Loading",
              style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            );
          }
          var userDocument = snapshot.data;
          return new Text(
            userDocument["total_sales"].toString(),
            style: TextStyle(
              color: Colors.green,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          );
        });
  }
}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.userId}) : super(key: key);

  final String userId;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(context),
      body: ListView(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(4.0, 1.0, 10.0, 1.0),
              child: Text(
                'Your Tally is Connected!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            color: const Color(0xff14D2B8),
            width: MediaQuery.of(context).size.width,
            height: 20,
          ),
          // Container 1 - Sales
          Container(
            child: SalesDashboardWidget(userId: widget.userId),
            margin: const EdgeInsets.all(15.0),
            // decoration: myBoxDecoration()
          ),
          Container(
            color: Color(0xffF3EEFE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Product Wise Sales',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  color: Colors.purple[800],
                )
              ],
            ),
          ),
          // Container 2 - Purchases
          Container(
            child: PurchaseDashboardWidget(),
            margin: const EdgeInsets.all(20.0),
            // decoration: myBoxDecoration()
          ),
          Container(
            color: Color(0xffF3EEFE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Check Pending Purchase Orders',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  color: Colors.purple[800],
                )
              ],
            ),
          ),
          Container(
            child: ExpenseDashboardWidget(),
            margin: const EdgeInsets.all(15.0),
            // decoration: myBoxDecoration()
          ),
          Container(
            color: Color(0xffF3EEFE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Check Expenses',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  color: Colors.purple[800],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Cash In Hand',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Text(
                      '21,24,230',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Cash In Bank',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Text(
                      '12,51,332',
                      style: TextStyle(fontSize: 17.0),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            color: Color(0xffF3EEFE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Check Bank Reconciliation',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  color: Colors.purple[800],
                )
              ],
            ),
          ),
          Container(
            child: OutstandingsDashboardWidget(),
            margin: const EdgeInsets.all(15.0),
            // decoration: myBoxDecoration()
          ),
          Container(
            color: Color(0xffF3EEFE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Account Payables',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  color: Colors.purple[800],
                )
              ],
            ),
          ),
          Container(
            color: Color(0xffF3EEFE),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Account Receivables',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  Icons.play_arrow,
                  color: Colors.purple[800],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomNav(),
    );
  }
}

class SalesDashboardWidget extends StatefulWidget {
  const SalesDashboardWidget({Key key, this.userId}) : super(key: key);

  final String userId;

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
          SalesDashboardWidgetContentRow(userId: widget.userId),
        ],
      ),
    );
  }
}

class SalesDashboardWidgetContentRow extends StatefulWidget {
  const SalesDashboardWidgetContentRow({Key key, this.userId})
      : super(key: key);

  final String userId;

  @override
  _SalesDashboardWidgetContentRowState createState() =>
      _SalesDashboardWidgetContentRowState();
}

class _SalesDashboardWidgetContentRowState
    extends State<SalesDashboardWidgetContentRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.green,
                  ),
                  SalesMetricText()
                ],
              ),
              Text('Revenue'),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.red,
                  ),
                  Text(
                    '200 Kg',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Quantity'),
            ],
          ),
        ),
        // SimpleTimeSeriesChart.withSampleData(),
      ],
    );
  }
}

class SalesDashboardWidgetTitleRow extends StatelessWidget {
  const SalesDashboardWidgetTitleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Sales',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.bookmark,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.share,
                color: Colors.purple[800],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PurchaseDashboardWidget extends StatelessWidget {
  const PurchaseDashboardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: PurchaseDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          PurchaseDashboardWidgetContentRow(),
        ],
      ),
    );
  }
}

class PurchaseDashboardWidgetContentRow extends StatelessWidget {
  const PurchaseDashboardWidgetContentRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.green,
                  ),
                  Text(
                    '6.8L',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Revenue'),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.red,
                  ),
                  Text(
                    '24',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Open orders'),
            ],
          ),
        ),
      ],
    );
  }
}

class PurchaseDashboardWidgetTitleRow extends StatelessWidget {
  const PurchaseDashboardWidgetTitleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Purchase',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.bookmark,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.share,
                color: Colors.purple[800],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OutstandingsDashboardWidget extends StatelessWidget {
  const OutstandingsDashboardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: OutstandingsDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          OutstandingsDashboardWidgetContentRow(),
        ],
      ),
    );
  }
}

class OutstandingsDashboardWidgetContentRow extends StatelessWidget {
  const OutstandingsDashboardWidgetContentRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          children: <Widget>[
            Text(' '),
            Text('Payables'),
            Text('Receivables'),
          ],
        ),
        Column(
          children: <Widget>[
            Text('Target'),
            Text('12,42,000'),
            Text('21,24,230'),
          ],
        ),
        Column(
          children: <Widget>[
            Text('Actual'),
            Text(
              '2,42,000',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '12,51,332',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Text('Avg. Delay'),
            Text(
              '43 days',
              style: TextStyle(color: Colors.red),
            ),
            Text(
              '23 days',
              style: TextStyle(color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}

class OutstandingsDashboardWidgetTitleRow extends StatelessWidget {
  const OutstandingsDashboardWidgetTitleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Outstandings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.bookmark,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.share,
                color: Colors.purple[800],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ExpenseDashboardWidget extends StatelessWidget {
  const ExpenseDashboardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: ExpenseDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          ExpenseDashboardWidgetContentRow(),
        ],
      ),
    );
  }
}

class ExpenseDashboardWidgetContentRow extends StatelessWidget {
  const ExpenseDashboardWidgetContentRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.green,
                  ),
                  Text(
                    '1.2L',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Total Expenses'),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_down,
                    color: Colors.red,
                  ),
                  Text(
                    '20k',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Unpaid expenses'),
            ],
          ),
        ),
      ],
    );
  }
}

class ExpenseDashboardWidgetTitleRow extends StatelessWidget {
  const ExpenseDashboardWidgetTitleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Expenses',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.bookmark,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.share,
                color: Colors.purple[800],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
