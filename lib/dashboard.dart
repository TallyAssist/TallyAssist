import 'package:flutter/material.dart';
// import './linechart.dart';
import 'package:tassist/menu.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 12),
          child: IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MenuScreen(),
                ),
              );
            },
          ),
        ),
        title: Column(
          children: <Widget>[
            const Text('ABC Pvt Ltd'),
            const Text('Revenue: 123\$'),
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
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Sales',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
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
                ),
                const SizedBox(height: 10,),
                Row(
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
                    Container(
                      child: Text('Chart Placeholder!'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Container 2 - Purchases
        ],
      ),
      // bottomNavigationBar: ,
    );
  }
}
