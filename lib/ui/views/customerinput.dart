import 'package:flutter/material.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
// import 'package:contact_picker/contact_picker.dart';
import 'package:native_contact_picker/native_contact_picker.dart';


class CustomerInputScreen extends StatefulWidget {
  @override
  _CustomerInputScreenState createState() => _CustomerInputScreenState();
}

class _CustomerInputScreenState extends State<CustomerInputScreen> {

    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
     final NativeContactPicker _contactPicker = new NativeContactPicker();
  Contact _contact;
  var _partyType;
  Color _color;
 
  
Color changePartyButtonCreditor() {
  print(_color);
  print(_partyType);
   
  if (_partyType == 'Creditor') {
   return _color = TassistSuccessLight;
  }
  else {
   return _color = TassistBgLightPurple;
  }
}

Color changePartyButtonDebtor() {
  print(_color);
  print(_partyType);
   
  if (_partyType == 'Debtor') {
   return _color = TassistSuccessLight;
  }
  else {
   return _color = TassistBgLightPurple;
  }
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
            appBar: headerNav(_drawerKey),
            // bottomNavigationBar: bottomNav(),
            body: Padding(
              padding: spacer.all.xs,
              child: ListView(children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text('Create new contact', style: secondaryListTitle,),
                  TextFormField(
                    style: secondaryListDisc,
                    decoration: InputDecoration(
                      labelText: 'Customer Name',
                      labelStyle: secondaryListTitle2.copyWith(color: TassistInfoGrey)
                    ),
                  ),
                  TextFormField(
                    style: secondaryListDisc,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: secondaryListTitle2.copyWith(color: TassistInfoGrey)
                    ),
                  )

                ],),


                Padding(
                  padding: spacer.top.sm,
                  child: Row(
                    children: <Widget>[
                    Text('OR, select from address book: ', style: secondaryListTitle,), 
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle, 
                        color: TassistBgLightPurple,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: IconButton(
                      color: TassistPrimary,
                      icon: Icon(Icons.person_add),
                      focusColor: TassistPrimaryDarkButtonShadow,
                      onPressed: () async {
                        Contact contact = await _contactPicker.selectContact();
                        setState(() {
                          _contact = contact;
                        });
                      },
                  ),
                    )
                    ],
                  ),
                ),
                    Padding(
                      padding: spacer.bottom.sm,
                      child: Text(
                  _contact == null ? 'No contact selected.' : _contact.toString(), style: secondaryListDisc.copyWith(fontSize: 14),
                ),
                    ),
                Text('Party type', style: secondaryListTitle,), 
                Padding(
                  padding: spacer.y.xxs,
                  child: Row(
                    children: <Widget>[
                       RaisedButton(
                         child: Text('Customer/Debtor'),
                         color: changePartyButtonDebtor(),
                         splashColor:  TassistSuccessLight,
                    
                    onPressed: () =>  {
                   _partyType == 'Debtor'
                  }
                  ),
                  SizedBox(width: 10),
                  RaisedButton(
                         child: Text('Supplier/Creditor'),
                         color: changePartyButtonCreditor(),
                         highlightColor: TassistSuccessLight,
                    
                    onPressed: () =>  {
                    _partyType == 'Creditor'
                  }
                  )
                    ],

                  ),
                ),
                 Padding(
                   padding: spacer.top.sm,
                   child: Text('GSTIN (Optional)', style: secondaryListTitle,),
                 ),
                  TextFormField(
                    style: secondaryListDisc,
                    decoration: InputDecoration(
                      labelText: 'Input 12 digit GST ',
                      // TO DO put validation for 12 digits. 
                      labelStyle: secondaryListTitle2.copyWith(color: TassistInfoGrey)
                    ),
                  ),


                Container(
                  padding: spacer.top.sm,
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2,
                  child: RaisedButton(
                           child: Text('+ Save Party', style: secondaryListDisc.copyWith(color: TassistWhite)),
                           color: TassistPrimaryDarkButtonShadow,
                      onPressed: () {Navigator.of(context).pop();
                      }
                    ),
                )          
                ]
              ),
            ),
            
 

  
      
            


          )
        );
      
  }
}

