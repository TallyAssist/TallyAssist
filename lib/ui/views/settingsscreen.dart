import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/companyservice.dart';
import 'package:tassist/core/services/storageservice.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';
import 'package:signature/signature.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _imageFile;
  String _upiAddress;
  String _companyName;
  String _phoneNumber;
  String _gstNumber;
  String _registeredAddress;

  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  final SignatureController _controller =
      SignatureController(penStrokeWidth: 3, penColor: TassistBlack);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print("Value changed"));
  }

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<FirebaseUser>(context).uid;

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _drawerKey,
          drawer: tassistDrawer(context),
          appBar: headerNav(_drawerKey),
          // bottomNavigationBar: bottomNav(),
          body: Form(
            key: _formKey,
            child: ListView(children: <Widget>[
              SectionHeader('Settings'),
              SizedBox(
                height: 10,
              ),
              // LOGO PICKER
              Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.photo, color: TassistPrimaryBackground),
                      onPressed: () => _pickImage(ImageSource.gallery)),
                  Text('Select your company logo')
                ],
              ),
              // SAVE LOGO BUTTON
              RaisedButton(
                color: TassistPrimaryDarkButtonShadow,
                child: Text('Save logo',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: TassistWhite)),
                onPressed: () async {
                  await StorageService().uploadFile(_imageFile, uid + '_logo');
                  Firestore.instance
                      .collection('company')
                      .document(uid)
                      .setData({
                    'restat_has_logo': '1',
                  }, merge: true);

                  // return AlertDialog(
                  //     title: Text(
                  //       'Your logo has been uploaded',
                  //       style: secondaryListTitle,
                  //     ),
                  //     actions: <Widget>[
                  //       FlatButton(
                  //           onPressed: () => Navigator.of(context).pop(),
                  //           child: Text(
                  //             'Awesome!',
                  //             style: secondaryListDisc,
                  //           )),
                  //     ]);
                },
              ),
              // UPI Address
              Padding(
                padding: spacer.x.xxs,
                child: TextFormField(
                  style: secondaryListDisc,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.payment,
                      color: TassistPrimary,
                    ),
                    hintText: 'Input UPI account',
                    hintStyle: secondaryHint,
                    labelText: 'Your UPI address',
                    labelStyle: secondaryListTitle.copyWith(fontSize: 16),
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter UPI ID' : null,
                  onChanged: (val) => setState(() => _upiAddress = val),
                ),
              ),
              // COMPANY NAME
              Padding(
                padding: spacer.x.xxs,
                child: TextFormField(
                  style: secondaryListDisc,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.business,
                      color: TassistPrimary,
                    ),
                    hintText: 'Company Name to be displayed',
                    hintStyle: secondaryHint,
                    labelText: 'Your Company Name',
                    labelStyle: secondaryListTitle.copyWith(fontSize: 16),
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter company name' : null,
                  onChanged: (val) => setState(() => _companyName = val),
                ),
              ),
              // CONTACT NUMBER
              Padding(
                padding: spacer.x.xxs,
                child: TextFormField(
                  style: secondaryListDisc,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.phone_android,
                      color: TassistPrimary,
                    ),
                    hintText: 'Contact number',
                    hintStyle: secondaryHint,
                    labelText: 'Your phone number',
                    labelStyle: secondaryListTitle.copyWith(fontSize: 16),
                  ),
                  validator: (val) =>
                      val.isEmpty ? 'Please enter phone number' : null,
                  onChanged: (val) => setState(() => _phoneNumber = val),
                ),
              ),
              Padding(
                padding: spacer.x.xxs,
                child: TextFormField(
                  style: secondaryListDisc,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.chrome_reader_mode,
                      color: TassistPrimary,
                    ),
                    hintText: 'Input 12-digit GSTIN',
                    hintStyle: secondaryHint,
                    labelText: 'Your GSTIN',
                    labelStyle: secondaryListTitle.copyWith(fontSize: 16),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter party' : null,
                  onChanged: (val) => setState(() => _gstNumber = val),
                ),
              ),
              Padding(
                padding: spacer.x.xxs,
                child: TextFormField(
                  style: secondaryListDisc,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.add_location,
                      color: TassistPrimary,
                    ),
                    hintText: 'Input your registered address',
                    hintStyle: secondaryHint,
                    labelText: 'Your registered address',
                    labelStyle: secondaryListTitle.copyWith(fontSize: 16),
                  ),
                  validator: (val) => val.isEmpty ? 'Please enter party' : null,
                  onChanged: (val) => setState(() => _registeredAddress = val),
                ),
              ),
              Padding(
                padding: spacer.all.xxs,
                child: TextField(
                  style: secondaryListDisc,
                  decoration: InputDecoration(
                    contentPadding: spacer.all.xxs,
                    hintText: 'This will be shown on GST invoice',
                    hintStyle: secondaryHint,
                    labelText: 'Terms & Conditions for GST invoice',
                    labelStyle: secondaryListTitle.copyWith(fontSize: 16),
                  ),
                ),
              ),
              // SAVE INFO BUTTON
              RaisedButton(
                color: TassistPrimaryDarkButtonShadow,
                child: Text('Submit company info',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: TassistWhite)),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    // await UploadService().uploadFile(_imageFile, uid+'_logo');
                    await CompanyService(uid: uid).updateCompanyRecord(
                      upiAddress: _upiAddress,
                      companyName: _companyName,
                      gstNumber: _gstNumber,
                      phoneNumber: _phoneNumber,
                      registeredAddress: _registeredAddress,
                    );
                    // return AlertDialog(
                    //   title: Text(
                    //     'Company info uploaded successfully?',
                    //     style: secondaryListTitle,
                    //   ),
                    //   actions: <Widget>[
                    //     FlatButton(
                    //         onPressed: () => Navigator.of(context).pop(),
                    //         child: Text(
                    //           'Awesome!',
                    //           style: secondaryListDisc,
                    //         )),

                    //   ]);
                  }
                },
              ),

              Padding(
                padding: spacer.all.xs,
                child: Text('Record your signature (for GST Invoice)'),
              ),
              RaisedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text(
                          'Sign here',
                          style: secondaryListTitle,
                        ),
                        content: Padding(
                          padding: spacer.all.xs,
                          child: Signature(
                              controller: _controller,
                              height: 200,
                              backgroundColor: TassistInfoLight),
                        ),
                        actions: <Widget>[
                          IconButton(
                            icon: const Icon(Icons.check),
                            color: TassistSuccess,
                            onPressed: () async {
                              if (_controller.isNotEmpty) {
                                var data = await _controller.toPngBytes();
                                Navigator.of(context).pop();
                                // MaterialPageRoute(
                                //   builder: (BuildContext context) {
                                //     return Scaffold(
                                //       appBar: headerNav(_drawerKey),
                                //       body: Center(
                                //           child: Container(
                                //               color: TassistWhite,
                                //               child: Column(
                                //                 children: <Widget>[
                                //                   Image.memory(data),
                                //                   FlatButton(
                                // onPressed: () => Navigator.of(context).pop(),
                                // child: Text(
                                //   'Close',
                                //   style: secondaryListDisc,
                                // )
                                // )
                                //                 ],
                                //               )
                                //           )
                                //       )
                                //     );

                                //   },
                                // ),
                                // );
                              }
                            },
                          ),
                          //CLEAR CANVAS
                          IconButton(
                            icon: const Icon(Icons.clear),
                            color: TassistWarning,
                            onPressed: () {
                              setState(() => _controller.clear());
                              Navigator.of(context).pop();
                            },
                          ),
                        ]);
                  },
                ),
                child: Text('Record Sign',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: TassistWhite)),
                color: TassistPrimaryDarkButtonShadow,
                textColor: Colors.white,
                elevation: 5,
              ),

              //SIGNATURE CANVAS

              // OK AND CLEAR BUTTONS
              // Container(
              //   padding: spacer.x.xs,
              //   decoration: const BoxDecoration(color: TassistBgLightPurple),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              //       //SHOW EXPORTED IMAGE IN NEW ROUTE
              //       IconButton(
              //         icon: const Icon(Icons.check),
              //         color: TassistSuccess,
              //         onPressed: () async {
              //           if (_controller.isNotEmpty) {
              //             var data = await _controller.toPngBytes();
              //             Navigator.of(context).push(
              //               MaterialPageRoute(
              //                 builder: (BuildContext context) {
              //                   return Scaffold(
              //                     appBar: headerNav(_drawerKey),
              //                     body: Center(
              //                         child: Container(
              //                             color: TassistWhite,
              //                             child: Image.memory(data))),
              //                   );
              //                 },
              //               ),
              //             );
              //           }
              //         },
              //       ),
              //       //CLEAR CANVAS
              //       IconButton(
              //         icon: const Icon(Icons.clear),
              //         color: TassistWarning,
              //         onPressed: () {
              //           setState(() => _controller.clear());
              //         },
              //       ),
              //     ],
              //   ),
              // ),
            ]),
          ),
          // DELETE (EVERYTHING) BUTTON
          bottomNavigationBar: Padding(
            padding: spacer.all.xs,
            child: RaisedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: Text(
                        'Are you sure?',
                        style: secondaryListTitle,
                      ),
                      actions: <Widget>[
                        FlatButton(
                            onPressed: () => _launchURL(),
                            child: Text(
                              'Yes',
                              style: secondaryListDisc,
                            )),
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              'Cancel',
                              style: secondaryListDisc,
                            ))
                      ]);
                },
              ),
              child: Text('Delete Account', style: TextStyle(fontSize: 20)),
              color: TassistWarning,
              textColor: Colors.white,
              elevation: 5,
            ),
          ),
        ));
  }
}

_launchURL() async {
  const url =
      'https://api.whatsapp.com/send?phone=917759091029&text=I%20want%20to%20delete%20my%20account,%20thank%20you';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
