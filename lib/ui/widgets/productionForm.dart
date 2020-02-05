
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/theme/colors.dart';


class ProductionForm extends StatefulWidget {
  @override
  _ProductionFormState createState() => _ProductionFormState();
}

class _ProductionFormState extends State<ProductionForm> {
  
  var formatter = new DateFormat('dd-MM-yyyy');

  final _formKey = GlobalKey<FormState>();
  final List<String> product = ['Product A', 'Product B', 'Product C'];

  DateTime _currentDate;
  String  _currentProduct;
  String _currentProduction;

  @override
  Widget build(BuildContext context) {
    // IDFixTODO - get current user
    var user = Provider.of<FirebaseUser>(context);

    return Form(
      key:  _formKey,
      child: Column(
        children: <Widget>[
          Text('Enter data for the day'),
          SizedBox(height: 20.0,),
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
          SizedBox(height: 20.0),
          DropdownButtonFormField(
              value: _currentProduct ?? 'Product A',
             items: product.map( (product){
              return DropdownMenuItem(
                value: product,
                child: Text('$product')
                );   

            }).toList(),
            onChanged: (val) => setState(() => _currentProduct = val),
          ),
          SizedBox(height: 20.0),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: new InputDecoration(
            hintText: 'Enter Production',
            icon: new Icon(
              Icons.note_add,
              color: TassistBlack,
            )),
            validator: (val) => val.isEmpty ? 'Please enter production': null,
            onChanged: (val) => setState(() => _currentProduction = val),
          ),
          RaisedButton(
            color: TassistPrimary,
            child: Text('Submit', style: Theme.of(context).textTheme.body1.copyWith(
        color: TassistWhite
      )),
            onPressed: () async {
                if(_formKey.currentState.validate()) {
                  // IDFix - pass current user
                  await DatabaseService(uid: user.uid).createProductionRecord(
                    _currentDate ?? DateTime.now(), 
                    _currentProduct ?? 'Product A',
                    _currentProduction ?? '0',
                  );
                  Navigator.pop(context);
                }
               
            },
          )
        ],
      ),
      
    );
  }
}