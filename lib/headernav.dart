import 'package:flutter/material.dart';
import 'menu.dart';

AppBar headerNav(BuildContext context) {
  return AppBar(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'ABC Pvt Ltd',
              style: TextStyle(
                fontSize: 15,
                letterSpacing: 2.5,
              ),
            ),
            const Text(
              'Total Revenue: 123\$',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                letterSpacing: 1.0,
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
  );
}
