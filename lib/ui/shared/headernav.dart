import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';




AppBar headerNav(GlobalKey<ScaffoldState> _drawerkey) {

// headerNav(_drawerkey);

// GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
bool enabled = false;

  return AppBar(
    leading: Padding(
      padding: EdgeInsets.only(left: 12),
      child: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {
          // Navigator.of(context).pushReplacement(
          //   MaterialPageRoute(
          //     builder: (context) => MenuScreen(),
          //   ),
          // // );
           if (enabled) {

                         // open drawer if this value is true
            _drawerkey.currentState.openDrawer();
          } 
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
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const Text(
              'GSTIN: 29ABCDE1234F2Z5',
              style: TextStyle(
                color: TassistWhite,
                fontSize: 12,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        SizedBox(width: 10.0,),
        DropDownMonths(),
      ],
    ),
    backgroundColor: TassistMenuBg
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
            child: Text(value, style: Theme.of(context).textTheme.body1.copyWith(
              color: TassistPrimaryBackground
            ),),
            value: value,
        )).toList(),
        onChanged: (selectedMonth) {
          setState(() {
            selectedValue=selectedMonth;
          });
        },
        // value: Text(selectedValue.toString(), style: Theme.of(context).textTheme.body1.copyWith(
        //       color: TassistWhite,
        //       fontSize: 12.0,
        //     )),
        value: selectedValue,

        isExpanded: false,   
        hint: Text('Period', style: Theme.of(context).textTheme.body1.copyWith(
              color: TassistWhite,
              fontSize: 12.0,
            )),

      ),
    );
  }
}
