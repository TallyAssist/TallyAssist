import 'package:flutter/material.dart';
import './headernav.dart';
import './bottomnav.dart';
// import './theme.dart';

class SalesOrderReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerNav(context),
      bottomNavigationBar: bottomNav(),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            color: Color(0xffF3EEFE),
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Sales Order Report',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: Color(0xffEDF4FC),
                    child: Row(
                      children: <Widget>[
                        Text('Product'),
                        Icon(Icons.arrow_drop_down, color: Colors.purple[800]),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Color(0xffEDF4FC),
                    child: Row(
                      children: <Widget>[
                        Text('Customer'),
                        Icon(Icons.arrow_drop_down, color: Colors.purple[800]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  ColoredIconNumberRow(metric: '20.3L'),
                  ColoredIconNumberRow(metric: '23'),
                  ColoredIconNumberRow(metric: '1.05L'),
                ],
              ),
              Column(
                children: <Widget>[
                  ColoredIconNumberRow(metric: '200 tns'),
                  ColoredIconNumberRow(metric: '73 tns'),
                  ColoredIconNumberRow(metric: '20k'),
                ],
              )
            ],
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 20,
                    color: Color(0xffEDF4FC),
                    child: Row(
                      children: <Widget>[
                        Text('Pending Sales Order by'),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 20,
                    color: Color(0xffEDF4FC),
                    child: Row(
                      children: <Widget>[
                        Text('Due Date'),
                        Icon(Icons.arrow_drop_down, color: Colors.purple[800]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'XYZ Pvt Ltd.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Text(
                            '23 days',
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text('Rs. 1,23,890'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '123456',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '450 Nos.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
           Column(
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'XYZ Pvt Ltd.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Text(
                            '23 days',
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text('Rs. 1,23,890'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '123456',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '450 Nos.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'XYZ Pvt Ltd.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Text(
                            '23 days',
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text('Rs. 1,23,890'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '123456',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '450 Nos.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'XYZ Pvt Ltd.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Text(
                            '23 days',
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text('Rs. 1,23,890'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '123456',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '450 Nos.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'XYZ Pvt Ltd.',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          color: Colors.grey[200],
                          child: Text(
                            '23 days',
                            style: TextStyle(color: Colors.red, fontSize: 15.0),
                          ),
                        ),
                      ],
                    ),
                    Text('Rs. 1,23,890'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '123456',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      '450 Nos.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          )
        
        
        
        
        ],
      ),
    );
  }
}

class ColoredIconNumberRow extends StatefulWidget {
  final String metric;
  ColoredIconNumberRow({String metric}) : this.metric = metric;

  @override
  _ColoredIconNumberRowState createState() =>
      _ColoredIconNumberRowState(metric);
}

class _ColoredIconNumberRowState extends State<ColoredIconNumberRow> {
  _ColoredIconNumberRowState(this.metric);
  final String metric;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.arrow_drop_up,
                color: Colors.green,
                size: 30.0,
              ),
              Text(
                metric,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
          Text(
            'Placeholder',
            style: TextStyle(fontSize: 20.0),
          )
        ],
      ),
    );
  }
}
