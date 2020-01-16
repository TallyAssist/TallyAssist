// Pending issue - dropdown widget not displaying value

import 'package:flutter/material.dart';
import 'package:tassist/menu.dart';
// import './myboxdecoration.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 12),
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MenuScreen(),
                ),
              );
            },
          ),
        ),
        title: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text(
                  'ABC Pvt Ltd',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(
                  'Revenue: 123\$',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            DropdownButton(
              value: '1 month',
              items: <String>['1 month', '3 months', '6 months', '1 year']
                  .map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (_) {},
              // isExpanded: true,
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_alarm),
            onPressed: null,
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          // Container 1 - Sales
          Container(
            child: SalesDashboardWidget(),
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            // decoration: myBoxDecoration()
          ),
          // Container 2 - Purchases
          Container(
            child: PurchaseDashboardWidget(),
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            // decoration: myBoxDecoration()
          ),
          Container(
            child: OutstandingsDashboardWidget(),
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(10.0),
            // decoration: myBoxDecoration()
          ),
        ],
      ),
      // bottomNavigationBar: ,
    );
  }
}

class SalesDashboardWidget extends StatelessWidget {
  const SalesDashboardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: SalesDashboardWidgetTitleRow(),
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          SalesDashboardWidgetContentRow(),
        ],
      ),
    );
  }
}

class SalesDashboardWidgetContentRow extends StatelessWidget {
  const SalesDashboardWidgetContentRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                  ),
                  Text(
                    '20.3L',
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
                    Icons.arrow_downward,
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
                Icons.info,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
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
            color: Colors.grey,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_upward,
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
                    Icons.arrow_upward,
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
                Icons.info,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
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
            color: Colors.grey,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                Icons.info,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
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
