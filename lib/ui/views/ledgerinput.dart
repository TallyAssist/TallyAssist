import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/core/models/stockitem.dart';
import 'package:tassist/core/services/vouchers.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/texts.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/widgets/productcard.dart';

class LedgerInputScreen extends StatefulWidget {
  @override
  _LedgerInputScreenState createState() => _LedgerInputScreenState();
}

class _LedgerInputScreenState extends State<LedgerInputScreen> {
  bool checkboxValue = false;
  List productList = [];

  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _customerName;
  // Product details
  String _productName;
  String _gstPercentage;
  String _productPrice;
  String _productQuantity;
  double _totalProductPrice = 0;
  double _totalTax = 0;

  String _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String _dueDate = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().add(new Duration(days: 30)));
  bool isCashSwitched = true;
  //      final List<String> discountPerCent = ['5','10', '15', '20'];

  // String _currentDiscount;

  cashCredit(bool isCashSwitched) {
    if (isCashSwitched == true) {
      return Text('Cash');
    } else {
      return Text('Credit');
    }
  }

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<FirebaseUser>(context).uid;
    var ledgerList = Provider.of<List<LedgerItem>>(context, listen: false);
    var stockList = Provider.of<List<StockItem>>(context, listen: false);

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
            appBar: headerNav(_drawerKey),
            // bottomNavigationBar: bottomNav(),
            body: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Padding(
                    padding: spacer.x.xxs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                      Text('Invoice ',
                          style: secondaryListDisc.copyWith(
                              color: TassistPrimary)),
                      Text('#12345'),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text('Date: $_currentDate', style: TextStyle(color: TassistInfoGrey)),
                      IconButton(
                        icon: Icon(Icons.date_range),
                        color: TassistPrimary,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2001),
                            lastDate: DateTime(2022),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                    //OK/Cancel button text color
                                    primaryColor: const Color(
                                        0xFF4A5BF6), //Head background
                                    accentColor: const Color(
                                        0xFF4A5BF6) //selection color
                                    //dialogBackgroundColor: Colors.white,//Background color
                                    ),
                                child: child,
                              );
                            },
                          ).then((date) {
                            _currentDate =
                                DateFormat('dd-MM-yyyy').format(date);
                          });
                        },
                      )
                    ])),
                Padding(
                  padding: spacer.x.xxs,
                  child: Row(children: <Widget>[
                    Text('Due Date: $_dueDate'),
                    IconButton(
                      icon: Icon(Icons.date_range),
                      color: TassistPrimary,
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.now().add(new Duration(days: 30)),
                          firstDate: DateTime(2001),
                          lastDate: DateTime(2022),
                          builder: (BuildContext context, Widget child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                  //OK/Cancel button text color
                                  primaryColor:
                                      const Color(0xFF4A5BF6), //Head background
                                  accentColor:
                                      const Color(0xFF4A5BF6) //selection color
                                  //dialogBackgroundColor: Colors.white,//Background color
                                  ),
                              child: child,
                            );
                          },
                        ).then((date) {
                          _dueDate = DateFormat('dd-MM-yyyy').format(date);
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    cashCredit(isCashSwitched),
                    Switch(
                      value: isCashSwitched,
                      onChanged: (value) {
                        setState(() {
                          isCashSwitched = value;
                        });
                      },
                      activeTrackColor: TassistBgLightPurple,
                      activeColor: TassistPrimary,
                    ),
                  ]),
                ),
                Padding(
                  padding: spacer.all.xxs,
                  child: Container(
                      child: Padding(
                        padding: spacer.all.xxs,
                        child: DropdownButtonFormField(
                          items: ledgerList.map((l) {
                            return DropdownMenuItem(
                              child: Text(l.name),
                              value: l.name,
                            );
                          }).toList(),
                          style: secondaryListDisc,
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person_add,
                              color: TassistPrimary,
                            ),
                            hintText: 'Select customer',
                            hintStyle: secondaryHint,
                            labelText: 'Customer name',
                            labelStyle:
                                secondaryListTitle.copyWith(fontSize: 16),
                          ),
                          onChanged: (val) =>
                              setState(() => _customerName = val),
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(color: TassistPrimary),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: TassistBgLightPurple)),
                ),
                Padding(
                  padding: spacer.all.xxs,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            'GST: ABCDEFGHIJKLM',
                            style: secondaryListTitle2,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(Icons.phone, color: TassistPrimary),
                              Text(
                                ' 7759091029  ',
                                style: secondaryListTitle2,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),

                // Container(
                //   color: TassistInfoGrey,
                //   height: 2,
                // ),
                Padding(
                    padding: spacer.left.xxs,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          flex: 3,
                          child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButtonFormField(
                                  items: stockList.map((p) {
                                    return DropdownMenuItem(
                                      child: Text(p.name),
                                      value: p.name,
                                    );
                                  }).toList(),
                                  style: secondaryListDisc,
                                  decoration: InputDecoration(
                                      icon: Icon(
                                        Icons.playlist_add,
                                        color: TassistPrimary,
                                      ),
                                      hintText: 'Add product',
                                      hintStyle: secondaryHint,
                                      labelText: 'Product to be billed',
                                      labelStyle: secondaryListTitle.copyWith(
                                          fontSize: 16)),
                                  onChanged: (val) =>
                                      setState(() => _productName = val),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: TassistPrimary),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: TassistBgLightPurple)),
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          flex: 1,
                          child: new TextFormField(
                            style: secondaryListDisc,
                            decoration: InputDecoration(
                                labelText: 'GST %',
                                labelStyle: secondaryListDisc),
                            onChanged: (val) =>
                                setState(() => _gstPercentage = val),
                          ),
                        ),
                      ],
                    )),

                Padding(
                  padding: spacer.all.xxs,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: new TextFormField(
                          style: secondaryListDisc,
                          decoration: InputDecoration(
                              icon: Icon(Icons.attach_money,
                                  color: TassistPrimary),
                              contentPadding: EdgeInsets.all(10),
                              labelText: 'Price',
                              labelStyle: secondaryListDisc),
                          onChanged: (val) =>
                              setState(() => _productPrice = val),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      new Flexible(
                        child: new TextFormField(
                          style: secondaryListDisc,
                          decoration: InputDecoration(
                              icon: Icon(Icons.shopping_cart,
                                  color: TassistPrimary),
                              contentPadding: EdgeInsets.all(10),
                              labelText: 'Qty',
                              labelStyle: secondaryListDisc),
                          onChanged: (val) =>
                              setState(() => _productQuantity = val),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      new Flexible(
                        child: RaisedButton(
                          // Add to productList
                          onPressed: () {
                            // 'Product 1', 'HSN Code: ABCDEF',
                            //       '100 Qty @ 10/item',
                            //       'GST @ 5%: 50',
                            //       'Amount: 1000',
                            //       'Discount: 10'
                            double amount = double.parse(_productQuantity) *
                                double.parse(_productPrice);
                            double gstAmount =
                                ((double.parse(_gstPercentage)) / 100) * amount;
                            List tempList = [
                              _productName,
                              'HSN Code: ',
                              '$_productQuantity Qty @ $_productPrice/item',
                              'GST @ $_gstPercentage% : $gstAmount',
                              'Amount: $amount',
                              'Discount: ',
                            ];
                            setState(() {
                              _totalProductPrice += amount;
                              _totalTax += gstAmount;
                              productList.add(tempList);
                            });
                          },
                          child: Icon(
                            Icons.add,
                            color: TassistWhite,
                          ),
                          color: TassistPrimaryDarkButtonShadow,
                          textColor: Colors.white,
                          elevation: 5,
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: productList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                          productList[index][0],
                          productList[index][1],
                          productList[index][2],
                          productList[index][3],
                          productList[index][4],
                          productList[index][5]);
                    },
                  ),
                ),
                // DropdownButtonFormField(
                //   // value: "16",
                //   items: <DropdownMenuItem>[
                //     DropdownMenuItem(value: "1", child: Text("1"),),
                //   ],
                // ['16', '2'].map((trantype) {
                //   return DropdownMenuItem(
                //     value: "22",
                //     child: Text('16', style: secondaryListDisc),
                //   );
                // }).toList(),
                // decoration: new InputDecoration(
                //     hintStyle: secondaryListDisc,
                //     hintText: 'Discount %',
                //     icon: new Icon(
                //       Icons.save,
                //       color: TassistBlack,
                //     )),
                //   onChanged: (val) => setState(() => _currentDate = val),
                // ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxValue,
                              onChanged: (bool value) {
                                setState(() {
                                  print(value);
                                  checkboxValue = value;
                                });
                              },
                              activeColor: TassistPrimary,
                            ),
                            Text(
                              'Include payment link',
                              style: secondaryListDisc,
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: spacer.all.xxs,
                      child: Column(
                        children: <Widget>[
                          Text('Total: $_totalProductPrice',
                              style: secondaryListTitle.copyWith(fontSize: 18)),
                          Text(
                            'Tax: $_totalTax',
                            style: secondaryListTitle2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ]),
            ),
            bottomNavigationBar: Row(
              children: <Widget>[
                Flexible(
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () async {
                        await VoucherService(uid: uid).saveVoucherRecord(
                          amount: (_totalProductPrice + _totalTax),
                          isInvoice: '1',
                          partyname: _customerName,
                          primaryVoucherType: 'Sales',
                          type: 'Sales',
                        );
                      },
                      child: Text('Preview', style: TextStyle(fontSize: 20)),
                      color: TassistInfoGrey,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                ),
                Flexible(
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () {},
                      child: Text('Save', style: TextStyle(fontSize: 20)),
                      color: TassistPrimary,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            )));
  }
}
