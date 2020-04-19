import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/company.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/core/models/stockitem.dart';
import 'package:tassist/core/models/voucher-item.dart';
import 'package:tassist/core/services/voucher-item-service.dart';
import 'package:tassist/core/services/vouchers.dart';
import 'package:tassist/templates/invoice_pdf_template.dart';
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

  String _invoiceNumber = Random().nextInt(10000).toString();
  String _masterId = Random().nextInt(100000).toString();
  // Customer details
  LedgerItem _customerLedger;
  String _customerName = '';
  String _customerGst = '';
  String _customerPhone = '';
  // Product details
  List<VoucherItem> _inventoryEntries = [];
  String _productName = '';
  String _gstPercentage;
  String _productPrice;
  String _productQuantity;
  double _totalProductPrice = 0;
  double _totalTax = 0;

  DateTime _invoiceDateRaw = DateTime.now();
  String _currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String _dueDate = DateFormat('dd-MM-yyyy')
      .format(DateTime.now().add(new Duration(days: 30)));
  bool isCashSwitched = true;
  //      final List<String> discountPerCent = ['5','10', '15', '20'];
  // TODO due date to be changed as per credit period.

  // String _currentDiscount;

  cashCredit(bool isCashSwitched) {
    if (isCashSwitched == true) {
      return Text(
        'Cash',
        style: secondaryListDisc.copyWith(color: TassistMenuBg),
      );
    } else {
      return Text('Credit',
          style: secondaryListDisc.copyWith(color: TassistInfoGrey));
    }
  }

  @override
  Widget build(BuildContext context) {
    var uid = Provider.of<FirebaseUser>(context).uid;
    var ledgerList = Provider.of<List<LedgerItem>>(context, listen: false);
    var stockList = Provider.of<List<StockItem>>(context, listen: false);
    var company = Provider.of<Company>(context);

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
            appBar: headerNav(_drawerKey),
            // bottomNavigationBar: bottomNav(),
            body: Form(
              key: _formKey,
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                Padding(
                    padding: spacer.x.xxs,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('Invoice ',
                              style: secondaryListDisc.copyWith(
                                  color: TassistInfoGrey)),
                          Text('#12345'),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text('Date:',
                              style: TextStyle(color: TassistInfoGrey)),
                          Text(_currentDate),
                          IconButton(
                            icon: Icon(Icons.date_range),
                            color: TassistMenuBg,
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
                                _invoiceDateRaw = date;
                                _currentDate =
                                    DateFormat('dd-MM-yyyy').format(date);
                              });
                            },
                          )
                        ])),
                Padding(
                  padding: spacer.x.xxs,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        cashCredit(isCashSwitched),
                        Switch(
                          value: isCashSwitched,
                          onChanged: (value) {
                            setState(() {
                              isCashSwitched = value;
                            });
                          },
                          activeTrackColor: TassistBgLightPurple,
                          activeColor: TassistMenuBg,
                        ),
                        SizedBox(width: 10),
                        Text('Due Date:',
                            style: secondaryListDisc.copyWith(
                                color: TassistInfoGrey)),
                        Text('$_dueDate'),
                        IconButton(
                          icon: Icon(Icons.date_range),
                          color: TassistMenuBg,
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
                              _dueDate = DateFormat('dd-MM-yyyy').format(date);
                            });
                          },
                        ),
                      ]),
                ),
                Padding(
                  padding: spacer.all.xxs,
                  child: Container(
                    // width: MediaQuery.of(context).size.width / 1.2,
                    child: Padding(
                      padding: spacer.all.xxs,
                      child: Center(
                        child: DropdownButtonFormField(
                          // value: _customerName,
                          isExpanded: true,
                          items: ledgerList.map((l) {
                            return DropdownMenuItem(
                              child: Text(l.name),
                              value: l,
                            );
                          }).toList(),
                          style: secondaryListDisc,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            icon: Icon(
                              Icons.person,
                              color: TassistPrimary,
                            ),
                            hintText: 'Select customer',
                            hintStyle: secondaryHint,
                            labelText: 'Customer name',
                            labelStyle:
                                secondaryListTitle.copyWith(fontSize: 16),
                          ),
                          onChanged: (val) {
                            setState(() {
                              _customerLedger = val;
                              _customerName = val.name;
                              _customerGst = (val.gst ?? '');
                              _customerPhone = (val.phone ?? '');
                            });
                          },
                        ),
                      ),
                    ),
                    // decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.all(Radius.circular(8)),
                    //     color: TassistBgLightPurple)
                  ),
                ),
                Padding(
                  padding: spacer.x.xxs,
                  child: Text(
                    _customerName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 12.0,
                        ),
                  ),
                ),
                Padding(
                  padding: spacer.x.xxs,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'GST: $_customerGst',
                        style: secondaryListTitle2.copyWith(
                            color: TassistInfoGrey),
                      ),
                      SizedBox(width: 30),
                      Icon(Icons.phone, color: TassistMenuBg),
                      Text(
                        '$_customerPhone',
                        style: secondaryListTitle2,
                      )
                    ],
                  ),
                ),

                // Container(
                //   color: TassistInfoGrey,
                //   height: 2,
                // ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 3,
                        child: Container(
                          child: DropdownButtonFormField(
                            // value: _productName,
                            isExpanded: true,
                            items: stockList.map((p) {
                              return DropdownMenuItem(
                                child: Text(p.name),
                                value: p,
                              );
                            }).toList(),
                            style: secondaryListDisc,
                            decoration: InputDecoration(
                                icon: Icon(
                                  Icons.playlist_add,
                                  color: TassistPrimary,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                hintText: 'Add product',
                                hintStyle: secondaryHint,
                                labelText: 'Add Product(s)',
                                labelStyle:
                                    secondaryListTitle.copyWith(fontSize: 16)),
                            onChanged: (val) =>
                                setState(() => _productName = val.name),
                          ),
                          // decoration: BoxDecoration(
                          //     border: Border.all(color: TassistPrimary),
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(8)),
                          //     color: TassistBgLightPurple)
                        ),
                      ),
                      SizedBox(width: 20),
                      Flexible(
                        flex: 1,
                        child: new TextFormField(
                          keyboardType: TextInputType.number,
                          style: secondaryListDisc,
                          decoration: InputDecoration(
                              labelText: 'GST %',
                              // AT: This should be a dropdown
                              labelStyle: secondaryListDisc),
                          onChanged: (val) =>
                              setState(() => _gstPercentage = val),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: spacer.x.xxs,
                  child: Text(
                    _productName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 12.0,
                        ),
                  ),
                ),
                Padding(
                  padding: spacer.x.xs,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new Flexible(
                        child: new TextFormField(
                          style: secondaryListDisc,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(Icons.attach_money,
                                  color: TassistPrimary),
                              contentPadding: EdgeInsets.all(8),
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
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              icon: Icon(Icons.shopping_cart,
                                  color: TassistPrimary),
                              contentPadding: EdgeInsets.all(8),
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
                              _inventoryEntries.add(VoucherItem(
                                actualQty: _productQuantity,
                                amount: amount,
                                billedQty: double.parse(_productQuantity),
                                discount: '',
                                gstPercent: _gstPercentage,
                                partyLedgerName: _customerName,
                                primaryVoucherType: 'Sales',
                                rate: _productPrice,
                                stockItemName: _productName,
                                taxAmount: gstAmount.toString(),
                                vDate: _invoiceDateRaw,
                                // vMasterId:
                              ));

                              _totalProductPrice += amount;
                              _totalTax += gstAmount;
                              productList.add(tempList);
                              _productName = '';
                              _productPrice = '';
                              _productQuantity = '';
                              _gstPercentage = '';
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
                // PREVIEW Invoice
                Flexible(
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    child: RaisedButton(
                      onPressed: () async {
                        await viewPdf(
                          company: company,
                          context: context,
                          invoiceDate: _currentDate,
                          ledger: _customerLedger,
                          inventoryEntries: _inventoryEntries,
                          totalAmount: (_totalProductPrice + _totalTax),
                          invoiceNumber: _invoiceNumber,
                          preview: true,
                        );
                      },
                      child: Text('Preview', style: TextStyle(fontSize: 20)),
                      color: TassistInfoGrey,
                      textColor: Colors.white,
                      elevation: 5,
                    ),
                  ),
                ),
                // SAVE and SEND Invoice
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
                          date: _invoiceDateRaw,
                          number: _invoiceNumber,
                          masterId: _masterId,
                        );

                        for (var i = 0; i < _inventoryEntries.length; i++) {
                          await VoucherItemService(uid: uid)
                              .saveVoucherItemRecord(
                            actualqty: _inventoryEntries[i].actualQty,
                            amount: _inventoryEntries[i].amount,
                            billedQty: _inventoryEntries[i].billedQty,
                            gstPercent: _inventoryEntries[i].gstPercent,
                            partyLedgerName:
                                _inventoryEntries[i].partyLedgerName,
                            primaryVoucherType:
                                _inventoryEntries[i].primaryVoucherType,
                            rate: _inventoryEntries[i].rate,
                            stockItemName: _inventoryEntries[i].stockItemName,
                            taxAmount: _inventoryEntries[i].taxAmount,
                            vdate: _inventoryEntries[i].vDate,
                            vMasterId: _inventoryEntries[i].vMasterId,
                          );
                        }

                        await viewPdf(
                          company: company,
                          context: context,
                          invoiceDate: _currentDate,
                          ledger: _customerLedger,
                          inventoryEntries: _inventoryEntries,
                          totalAmount: (_totalProductPrice + _totalTax),
                          invoiceNumber: _invoiceNumber,
                          preview: false,
                        );
                      },
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

viewPdf(
    {context,
    inventoryEntries,
    company,
    ledger,
    invoiceDate,
    totalAmount,
    invoiceNumber,
    preview}) async {
  // List<VoucherItem> inventoryEntries =
  //     Provider.of<List<VoucherItem>>(context, listen: false);

  final itemList = _createInvoiceItemList(inventoryEntries, totalAmount);

  final pdf = createInvoicePdf(
    invoiceNumber: invoiceNumber,
    invoiceDate: invoiceDate,
    companyName: company.formalName,
    companyAddress: company.address,
    companyPincode: company.pincode,
    partyName: ledger.name,
    partyAddress: ledger.address,
    partyPincode: ledger.pincode,
    partyState: ledger.state,
    partyGST: ledger.gst,
    itemList: itemList,
  );

  final String dir = (await getExternalStorageDirectory()).path;
  final path = "$dir/invoice_tallyassist.pdf";
  print(path);
  final file = File(path);
  await file.writeAsBytes(pdf.save());

  if (preview) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PdfViewerPage(path: path),
      ),
    );
  } else {
    try {
      final Uint8List bytes1 = await file.readAsBytes();
      //  rootBundle.load('assets/image1.png');

      await Share.files(
          'esys images',
          {
            'invoice_tallyassist.pdf': bytes1,
          },
          '*/*',
          text: 'My optional text.');
    } catch (e) {
      print('error: $e');
    }
  }

  // return PdfViewerPage(path: path);
}

class PdfViewerPage extends StatelessWidget {
  final String path;
  const PdfViewerPage({Key key, this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      path: path,
    );
  }
}

_createInvoiceItemList(inventoryEntries, amount) {
  List<List<String>> itemList = [
    [
      'SI No.',
      'Description of Goods',
      'HSN/SAC',
      'Quantity',
      'Rate',
      'per',
      'Disc',
      'Amount'
    ]
  ];

  // We add relevant data to itemList
  for (var i = 0; i < inventoryEntries.length; i++) {
    String serialNo = (i + 1).toString();
    String itemDescription = inventoryEntries[i]?.stockItemName ?? "";
    String hsnSac = "";
    String quantity = inventoryEntries[i]?.actualQty.toString() ?? "";
    String rate = inventoryEntries[i]?.rate.toString() ?? "";
    String unit = "";
    String discount = inventoryEntries[i]?.discount.toString() ?? "";
    String amount = inventoryEntries[i]?.amount.toString() ?? "";
    String taxAmount = inventoryEntries[i]?.taxAmount?.toString() ?? "";

    itemList.add([
      serialNo,
      itemDescription,
      hsnSac,
      quantity,
      rate,
      unit,
      discount,
      amount
    ]);
    itemList.add(["", "Tax", "", "", "", "", taxAmount]);
  }

  itemList.add(["", "Total", "", "", "", "", "", "", amount.toString()]);

  return itemList;
}
