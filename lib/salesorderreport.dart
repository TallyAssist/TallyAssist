import 'package:flutter/material.dart';
import './menu.dart';

class SalesOrderReportScreen extends StatelessWidget {
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
                  // builder: (context) => MenuScreen(),
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
                const Text('ABC Pvt Ltd'),
                const Text(
                  'Revenue: 123\$',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            // DropdownButton(
            //   value: '1 month',
            //   items: <String>['1 month', '3 months', '6 months', '1 year']
            //       .map((String value) {
            //     return new DropdownMenuItem<String>(
            //       value: value,
            //       child: new Text(value),
            //     );
            //   }).toList(),
            //   onChanged: (_) {},
            //   isExpanded: true,
            // ),
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
      body: Container(child: SalesOrderReportList()),
    );
  }
}

class SalesOrderReportList extends StatelessWidget {
  const SalesOrderReportList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          // Headline
          Container(
            child: SalesOrderReportWidgetTitleRow(),
            color: Colors.grey,
            height: 50,
          ),
          const SizedBox(
            height: 5,
          ),
          // Product and Customer subheadings
          Container(           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(flex: 5, child: SalesOrderReportProductSubtitle()),
                Flexible(flex: 5, child: SalesOrderReportCustomerSubtitle()),
              ],
            ),
            height: 20,
          ),
          // Product and Customer metrics
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Text(
                    "₹20.3L",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff219653),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 3,
                    ),
                  ),
                  new Text(
                    "23",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff219653),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 3,
                    ),
                  ),
                  new Text(
                    "₹1.05L",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xffeb5757),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  new Text(
                    "₹20.3L",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff219653),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 3,
                    ),
                  ),
                  new Text(
                    "23",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xff219653),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 3,
                    ),
                  ),
                  new Text(
                    "₹1.05L",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xffeb5757),
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 3,
                    ),
                  ),
                ],
              ),
            ],
          )
          // Pending Sales list
        ],
      ),
    );
  }
}

class SalesOrderReportCustomerSubtitle extends StatelessWidget {
  const SalesOrderReportCustomerSubtitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        children: <Widget>[
          new Text(
            "Customer",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              letterSpacing: 2,
            ),
          ),
          Icon(
            Icons.arrow_downward,
            color: Colors.purple[400],
          ),
        ],
      ),
    );
  }
}

class SalesOrderReportProductSubtitle extends StatelessWidget {
  const SalesOrderReportProductSubtitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Row(
        children: <Widget>[
          new Text(
            "Product A",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              letterSpacing: 2,
            ),
          ),
          Icon(
            Icons.arrow_downward,
            color: Colors.purple[400],
          ),
        ],
      ),
    );
  }
}

class SalesOrderReportWidgetTitleRow extends StatelessWidget {
  const SalesOrderReportWidgetTitleRow({
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
              new Text("Sales Order Report",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xff000000),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 2,
                  )),
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

// class SalesDashboardWidgetContentRow extends StatelessWidget {
//   const SalesDashboardWidgetContentRow({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Container(
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.arrow_upward,
//                     color: Colors.green,
//                   ),
//                   Text(
//                     '20.3L',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ],
//               ),
//               Text('Revenue'),
//             ],
//           ),
//         ),
//         Container(
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Icon(
//                     Icons.arrow_downward,
//                     color: Colors.red,
//                   ),
//                   Text(
//                     '200 Kg',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ],
//               ),
//               Text('Quantity'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
