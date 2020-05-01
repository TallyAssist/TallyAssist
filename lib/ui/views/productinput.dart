import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/stockservice.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';

class ProductInputScreen extends StatefulWidget {
  @override
  _ProductInputScreenState createState() => _ProductInputScreenState();
}

class _ProductInputScreenState extends State<ProductInputScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

  String _masterId = Random().nextInt(100000).toString();
  String _productName;
  String _standardCost;
  String _standardPrice;
  String _baseUnits;
  String _closingBalance;
  String _minimumStock;
  String _reorderValue;

  @override
  Widget build(BuildContext context) {
    String uid = Provider.of<FirebaseUser>(context).uid;

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
                  Text(
                    'Create new product/service',
                    style: secondaryListTitle,
                  ),
                  TextFormField(
                      style: secondaryListDisc,
                      decoration: InputDecoration(
                          labelText: 'Product Name',
                          labelStyle: secondaryListTitle2.copyWith(
                              color: TassistInfoGrey)),
                      onChanged: (value) {
                        setState(() {
                          _productName = value;
                        });
                      }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: TextFormField(
                            style: secondaryListDisc,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Standard Price',
                                // Validate number
                                labelStyle: secondaryListTitle2.copyWith(
                                    color: TassistInfoGrey)),
                            onChanged: (value) {
                              setState(() {
                                _standardPrice = value;
                              });
                            }),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: TextFormField(
                            style: secondaryListDisc,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Standard Cost',
                                // Validate number
                                labelStyle: secondaryListTitle2.copyWith(
                                    color: TassistInfoGrey)),
                            onChanged: (value) {
                              setState(() {
                                _standardCost = value;
                              });
                            }),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      //     SizedBox(
                      //       width: MediaQuery.of(context).size.width / 2.3 ,
                      //       child: TextFormField(
                      //   style: secondaryListDisc,
                      //   keyboardType: TextInputType.number,
                      //   decoration: InputDecoration(
                      //       labelText: 'Initial Stock',
                      //       labelStyle: secondaryListTitle2.copyWith(color: TassistInfoGrey),
                      //       hintText: 'Leave blank for service'
                      //   ),
                      // ),
                      //     ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: TextFormField(
                            style: secondaryListDisc,
                            decoration: InputDecoration(
                                labelText: 'Unit',
                                labelStyle: secondaryListTitle2.copyWith(
                                    color: TassistInfoGrey)),
                            onChanged: (value) {
                              setState(() {
                                _baseUnits = value;
                              });
                            }),
                      )
                    ],
                  )
                ],
              ),
              Padding(
                padding: spacer.top.sm,
                child: Text(
                  'Optional',
                  style: secondaryListTitle,
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: TextFormField(
                          style: secondaryListDisc,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Initial Stock',
                            labelStyle: secondaryListTitle2.copyWith(
                                color: TassistInfoGrey),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _closingBalance = value;
                            });
                          }),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: TextFormField(
                          style: secondaryListDisc,
                          decoration: InputDecoration(
                              labelText: 'Min Stock',
                              labelStyle: secondaryListTitle2.copyWith(
                                  color: TassistInfoGrey)),
                          onChanged: (value) {
                            setState(() {
                              _minimumStock = value;
                            });
                          }),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: TextFormField(
                        style: secondaryListDisc,
                        decoration: InputDecoration(
                            labelText: 'Reorder Value',
                            labelStyle: secondaryListTitle2.copyWith(
                                color: TassistInfoGrey)),
                        onChanged: (value) {
                          setState(() {
                            _reorderValue = value;
                          });
                        }),
                  ),
                ],
              ),
              Container(
                padding: spacer.top.sm,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2.5,
                child: RaisedButton(
                    child: Text('+ Save Item',
                        style: secondaryListDisc.copyWith(color: TassistWhite)),
                    color: TassistPrimaryDarkButtonShadow,
                    onPressed: () {
                      StockItemService(uid: uid).saveStockItem(
                        baseUnits: _baseUnits,
                        masterId: _masterId,
                        name: _productName,
                        standardCost: _standardCost,
                        standardPrice: _standardPrice,
                        minimumStock: _minimumStock ?? "",
                        reorderValue: _reorderValue ?? "",
                        closingBalance: _closingBalance ?? "",
                      );
                    }),
              )
            ]),
          ),
        ));
  }
}
