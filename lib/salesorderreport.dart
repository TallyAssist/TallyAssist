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
              isExpanded: true,
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
      body: Container(child: SalesOrderReportWidget()),
    );
  }
}

class SalesOrderReportWidget extends StatelessWidget {
  const SalesOrderReportWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          // Headline
          Container(
            child: SalesOrderReportWidgetTitleRow(),
            color: Colors.grey,
          ),
          const SizedBox(
            height: 20,
          ),
          // Product and Customer metrics
          Row(
            children: <Widget>[
              
            ],
          )
          // Pending Sales subheading

          // Pending Sales list
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
