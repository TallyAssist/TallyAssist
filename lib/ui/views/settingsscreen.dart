import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
   final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
   File _imageFile;

      Future<void> _pickImage(ImageSource source) async {
  File selected = await ImagePicker.pickImage(source: source);
  setState(() {
    _imageFile = selected;
  });
}



  @override
  Widget build(BuildContext context) {

    


    return WillPopScope (
              onWillPop: () async => false,
          child: Scaffold(
        key: _drawerKey,
        drawer: tassistDrawer(context),
        appBar: headerNav(_drawerKey),
        // bottomNavigationBar: bottomNav(),
        body: ListView(
          children: <Widget>[
            
            SectionHeader('Settings'),
            SizedBox(height: 20,),
            Row(
                children: <Widget>[
                   IconButton(icon: Icon(Icons.photo, color: TassistPrimary),
               
              onPressed: () => _pickImage(ImageSource.gallery)),
              Text('Select your company logo')


                ],
              ),
              Padding(
              padding: spacer.all.xxs,
              child: TextFormField(
                style: secondaryListDisc,
                decoration: InputDecoration(
                  icon: Icon(Icons.payment, color: TassistPrimary,),
                  hintText: 'Input UPI account',
                  hintStyle: secondaryHint,
                  labelText: 'Your UPI address',
                  labelStyle: secondaryListTitle.copyWith(fontSize: 16)
                ),
              ),
            ),
            SizedBox(height: 50),
           Padding(
             padding: spacer.all.xs,
             child: RaisedButton(
               onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                             return AlertDialog(
                                  title: Text('Are you sure?', style: secondaryListTitle,),
                                  actions: <Widget>[
                                    FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('Yes', style: secondaryListDisc,)),
                                    FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel', style: secondaryListDisc,))
                                  ]
                              );
                            },
                          ),

              child: Text('Delete Account', style: TextStyle(fontSize: 20)),
              color: TassistWarning,
              textColor: Colors.white,
              elevation: 5,),
           ),

           


          ]
        )
          )
    );
  }
}

