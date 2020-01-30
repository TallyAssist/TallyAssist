import 'package:flutter/material.dart';
import 'package:tassist/ui/views/menu.dart';

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
              'GSTIN: 29ABCDE1234F2Z5',
              style: TextStyle(
                color: Colors.green,
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        DropDownMonths(),
      ],
    ),
    backgroundColor: Colors.black,
  );
}

class DropDownMonths extends StatefulWidget {
  

  @override
  _DropDownMonthsState createState() => _DropDownMonthsState();
}

class _DropDownMonthsState extends State<DropDownMonths> {
  var selectedValue;

  List<String> _months=<String> 
  ['1 month', '3 months', '6 months', '1 year'];

  @override
  Widget build(BuildContext context) {
    return Expanded(child: DropdownButton(
        items: _months.map((value) => DropdownMenuItem(
            child: Text(value),
            value: value,
        )).toList(),
        onChanged: (selectedMonth) {
          setState(() {
            selectedValue=selectedMonth;
          });
        },
        value: selectedValue,
        hint: Text('Select Dates'),
        isExpanded: false,   

      ),
    );
  }
}
