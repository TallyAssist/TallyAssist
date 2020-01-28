
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/theme/colors.dart';


class ProductionForm extends StatefulWidget {
  @override
  _ProductionFormState createState() => _ProductionFormState();
}

class _ProductionFormState extends State<ProductionForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> product = ['Product A', 'Product B', 'Product C'];

  String _currentDate;
  String  _currentProduct;
  String _currentProduction;

  @override
  Widget build(BuildContext context) {
    return Form(
      key:  _formKey,
      child: Column(
        children: <Widget>[
          Text('Enter data for the day'),
          SizedBox(height: 20.0,),
          TextFormField(
            keyboardType: TextInputType.datetime,
            decoration: new InputDecoration(
            hintText: 'Enter Date',
            icon: new Icon(
              Icons.date_range,
              color: TassistBlack,
            )),
            validator: (val) => val.isEmpty ? 'Please select a date': null,
            onChanged: (val) => setState(() => _currentDate = val),
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
            child: Text('Submit'),
            onPressed: () async {
                if(_formKey.currentState.validate()) {
                  await DatabaseService().createProductionRecord(
                    _currentDate ?? DateTime.now(), 
                    _currentProduct ?? 'Product A',
                    _currentProduction ?? '0' 
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