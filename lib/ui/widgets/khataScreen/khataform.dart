
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/theme/colors.dart';


class KhataForm extends StatefulWidget {
  @override
  _KhataFormState createState() => _KhataFormState();
}

class _KhataFormState extends State<KhataForm> {

  var formatter = new DateFormat('dd-MM-yyyy');

  final _formKey = GlobalKey<FormState>();
  final List<String> trantype = ['Lia', 'Diya'];

  String _currentTranType;
  String _currentParty;
  String _currentAmount;
  DateTime _currentDate;


  @override
  Widget build(BuildContext context) {
    return Form(
      key:  _formKey,
      child: Column(
          children: <Widget>[
            Text('Apka private khata'),
            SizedBox(height: 20.0,),
           DropdownButtonFormField(
      value: _currentTranType,
      items: trantype.map((trantype) {
        return DropdownMenuItem(
          value: trantype,
          child: Text('$trantype'),
        );
      }
      ).toList(),
      decoration: new InputDecoration(
      hintText: 'Lia ki Diya?',
      icon: new Icon(
        Icons.fast_forward,
        color: TassistBlack,
      )),
      validator: (val) => val.isEmpty ? 'Please select a type': null,
      onChanged: (val) => setState(() => _currentTranType = val),
            ),
            SizedBox(height: 20.0),
            Row(children: <Widget>[ 
      Padding(
        padding: const EdgeInsets.fromLTRB(2.0, 8.0, 10.0, 8.0),
        child: Icon(Icons.date_range),
      ),
      Text(_currentDate == null ? 'Select a date': formatter.format(_currentDate).toString()),
      SizedBox(width: 10.0,),
      RaisedButton(
      child: Text('Date Picker'),
      color: TassistBgLightPurple,
      onPressed: () {
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2001),
          lastDate: DateTime(2022)
        ).then( (date) {
          _currentDate = date;
        }
        );
      },
      )
      ],
      ),

            TextFormField(
      initialValue: _currentParty,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(
      hintText: 'Enter Party',
      icon: new Icon(
        Icons.person_add,
        color: TassistBlack,
      )),
      validator: (val) => val.isEmpty ? 'Please enter party': null,
      onChanged: (val) => setState(() => _currentParty = val),
            ),
            SizedBox(height: 20.0),
            TextFormField(
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(
      hintText: 'Enter Amount',
      icon: new Icon(
        Icons.attach_money,
        color: TassistBlack,
      )),
      validator: (val) => val.isEmpty ? 'Please enter amount': null,
      onChanged: (val) => setState(() => _currentAmount = val ),
            ),
      SizedBox(height: 20.0,),

            RaisedButton(
      color: TassistPrimary,
      child: Text('Submit', style: Theme.of(context).textTheme.body1.copyWith(
        color: TassistWhite
      )),
      onPressed: () async {
          if(_formKey.currentState.validate()) {
            await DatabaseService().createKhataRecord(
              _currentDate ?? DateTime.now(),
              _currentParty ?? '',
              _currentAmount ?? '',
              _currentTranType ?? '',
             );
            Navigator.pop(context);
          //  Future.delayed(Duration(seconds: 5)).then((onValue) {
          //   Scaffold.of(context).showSnackBar(new SnackBar(
          //             content: Text("Wohoo! New transaction for $_currentParty added")
          //         ));
          //         });
          // }
          // else {
          //   AlertDialog(
          //     title: Text('No Input!'),
          //     actions: <Widget>[
          //       Text('Ok')
          //     ],
          //   );
          }
      },
            )
          ],
        ),
      
    );
  }
}