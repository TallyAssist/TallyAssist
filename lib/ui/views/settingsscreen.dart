import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';
import 'package:signature/signature.dart';

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

final SignatureController _controller = SignatureController(penStrokeWidth: 3, penColor: TassistBlack);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
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
            SizedBox(height: 10,),
            Row(
                children: <Widget>[
                   IconButton(icon: Icon(Icons.photo, color: TassistPrimary),
               
              onPressed: () => _pickImage(ImageSource.gallery)),
              Text('Select your company logo')


                ],
              ),
              Padding(
              padding: spacer.x.xxs,
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
            Padding(
              padding: spacer.x.xxs,
              child: TextFormField(
                style: secondaryListDisc,
                decoration: InputDecoration(
                  icon: Icon(Icons.business, color: TassistPrimary,),
                  hintText: 'Company Name to be displayed',
                  hintStyle: secondaryHint,
                  labelText: 'Your Company Name',
                  labelStyle: secondaryListTitle.copyWith(fontSize: 16)
                ),
              ),
            ),
            Padding(
              padding: spacer.x.xxs,
              child: TextFormField(
                style: secondaryListDisc,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone_android, color: TassistPrimary,),
                  hintText: 'Contact number',
                  hintStyle: secondaryHint,
                  labelText: 'Your phone number',
                  labelStyle: secondaryListTitle.copyWith(fontSize: 16)
                ),
              ),
            ),
            Padding(
              padding: spacer.x.xxs,
              child: TextFormField(
                style: secondaryListDisc,
                decoration: InputDecoration(
                  icon: Icon(Icons.chrome_reader_mode, color: TassistPrimary,),
                  hintText: 'Input 12-digit GSTIN',
                  hintStyle: secondaryHint,
                  labelText: 'Your GSTIN',
                  labelStyle: secondaryListTitle.copyWith(fontSize: 16)
                ),
              ),
            ),
            Padding(
              padding: spacer.x.xxs,
              child: TextFormField(
                style: secondaryListDisc,
                decoration: InputDecoration(
                  icon: Icon(Icons.add_location, color: TassistPrimary,),
                  hintText: 'Input your registered address',
                  hintStyle: secondaryHint,
                  labelText: 'Your registered address',
                  labelStyle: secondaryListTitle.copyWith(fontSize: 16)
                ),
              ),
            ),
            Padding(
              padding: spacer.all.xs,
              child: Text('Record your signature (for GST Invoice)'),
            ),
              //SIGNATURE CANVAS
              Padding(
                padding: spacer.all.xs,
                child: Signature(controller: _controller, height: 200, backgroundColor: TassistInfoLight),
              ),
              //OK AND CLEAR BUTTONS
              Container(
                padding: spacer.x.xs,
                decoration: const BoxDecoration(color: TassistBgLightPurple),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    //SHOW EXPORTED IMAGE IN NEW ROUTE
                    IconButton(
                      icon: const Icon(Icons.check),
                      color: TassistSuccess,
                      onPressed: () async {
                        if (_controller.isNotEmpty) {
                          var data = await _controller.toPngBytes();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return Scaffold(
                                  appBar: headerNav(_drawerKey),
                                  body: Center(child: Container(color: TassistWhite, child: Image.memory(data))),
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                    //CLEAR CANVAS
                    IconButton(
                      icon: const Icon(Icons.clear),
                      color: TassistWarning,
                      onPressed: () {
                        setState(() => _controller.clear());
                      },
                    ),
                  ],
                ),
              ),
          ]
        ),
        bottomNavigationBar:  Padding(
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
          )
    );
  }
}

