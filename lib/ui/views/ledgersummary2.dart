import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/company.dart';
import 'package:tassist/core/models/ledger.dart';
// import 'package:tassist/core/models/ledgervoucher.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/templates/ledgeraccount_pdf_template.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/services/string_format.dart';
import 'package:tassist/ui/shared/debitcredit.dart';
import 'package:tassist/ui/shared/positiveamount.dart';
import 'package:url_launcher/url_launcher.dart';

var formatter = new DateFormat('dd-MM-yyyy');

_formatDate(DateTime date) {
  if (date != null) {
    return formatter.format(date);
  } else {
    return 'NA';
  }
}





class LedgerSummary2 extends StatelessWidget {
  final String ledgerGuid;
  final String partyName;

  LedgerSummary2({this.ledgerGuid, this.partyName});

  @override
  Widget build(BuildContext context) {
    Iterable<LedgerItem> ledgerItem = Provider.of<List<LedgerItem>>(context)
            .where((item) => item.guid == ledgerGuid) ??
        [];
    LedgerItem ledger = ledgerItem?.elementAt(0) ?? [];
    
     _launchURL() async {
      var url = 'https://api.whatsapp.com/send?phone=${ledger.phone}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }







    // Here we get all vouchers for current ledger
    List<Voucher> voucherData;
    voucherData = Provider.of<List<Voucher>>(context, listen: false)
            .where((item) => item.partyGuid == ledgerGuid)
            .toList() ??
        [];

    Company company;
    company = Provider.of<Company>(context, listen: false);

    


    // final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Padding(
              padding: spacer.all.xs,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        child: Text(
                          ledger.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(color: TassistPrimary),
                        ))
                  ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'GST: ${ledger.gst}',
                          style: TextStyle(color: TassistInfoGrey),
                        ),
                        Row(
                          children: <Widget>[
                            // PDF Sharing button
                            RaisedButton(
                              child: Row(
                                children: <Widget>[
                                  Text('Send PDF', style: TextStyle(color: TassistMenuBg),),

                                ],
                              ),
                              onPressed: () => viewPdf(
                                  context, voucherData, company, ledger),
                              color: TassistBgLightPurple,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(icon: Icon(
                              FontAwesomeIcons.whatsapp,
                              color: TassistSuccess,
                            ), onPressed: () => _launchURL())
                            
                          ],
                        )
                      ])
                ],
              ),
            ),
            Container(height: 3.0, color: TassistPrimary),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: 
              Column(
                children: <Widget>[
                  Padding(
                    padding: spacer.all.xxs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Closing Balance'),
                        Text('${debitCredit(ledger.closingBalance)}')
                      ],
                    ),
                  ),
                  Padding(
                    padding: spacer.all.xxs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Opening Balance'),
                        Text('${debitCredit(ledger.openingBalance)}')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                    padding: spacer.all.xs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Sales'),
                        Text('${formatIndianCurrency(ledger.totalSales)}')
                      ],
                    ),
                  ),
             Padding(
                    padding: spacer.all.xs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Receipts'),
                        Text('${formatIndianCurrency(ledger.totalReceipt)}')
                      ],
                    ),
                  ),

             Padding(
                    padding: spacer.all.xs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Purchases'),
                        Text('${formatIndianCurrency(ledger.totalPurchase)}')
                      ],
                    ),
                  ),

               Padding(
                    padding: spacer.all.xs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Total Payment'),
                        Text('${formatIndianCurrency(ledger.totalPayment)}')
                      ],
                    ),
                  ),
                ],
              ),
            ),
        );
  }
}


viewPdf(context, voucherData, company, ledger) async {
  // CREATE LEDGER LIST
  // sort vouchers by date
  print(voucherData);
  // initiate an empty list with column headers
  List<List<String>> ledgerList = [
    ['Date', 'Vch No.', 'Vch Type', 'Dr./Cr.', 'Amount']
  ];
  // for each voucher:
  // 1. create a list of date, nature (credit/debit), ledger name, voucher type, voucher no, amount (debit/credit)
  // 2. for each inventory entry, create a list of itemname, itemquantity, rate, amount
  // 3. add lists from step 1 and 2 to the previously initiated list
  for (var i = 0; i < voucherData.length; i++) {
    // print(voucherData[i].amount);
    List<String> tempList;
    String natureTransaction;

    // TODO: what if amount is equal to 0?
    if (voucherData[i].amount > 0) {
      natureTransaction = 'Dr.';
    } else {
      natureTransaction = 'Cr.';
    }
    tempList = [
      _formatDate(voucherData[i].date),
      voucherData[i].number.toString(),
      voucherData[i].primaryVoucherType,
      natureTransaction,
      positiveAmount(voucherData[i].amount)
    ];
    ledgerList.add(tempList);
  }

  final pdf = createLedgerPdf(
    companyName: company.formalName,
    startDate: '01-04-2020', //TODO need to make this dynamic
    endDate: DateFormat('dd-MM-yyyy')
        .format(DateTime.now()), // TODO need to make this dynamic
    partyName: ledger.name,
    ledgerList: ledgerList,
    openingBalance: ledger.openingBalance.toString(),
    closingBalance: ledger.closingBalance.toString(),
  );

  // print("Voucher Data");
  // String partyNamePDF = ledger.name;

  final String dir = (await getExternalStorageDirectory()).path;
  final path = "$dir/Statement_tallyassist.pdf";
  print(path);
  final file = File(path);
  await file.writeAsBytes(pdf.save());

  try {
    final Uint8List bytes1 = await file.readAsBytes();
    //  rootBundle.load('assets/image1.png');

    await Share.files(
        'esys images',
        {
          'Statement_tallyassist.pdf': bytes1,
        },
        '*/*',
        text: 'Please find your party statement. Thanks for doing business with us!');
  } catch (e) {
    print('error: $e');
  }

  // return PdfViewerPage(path: path);

  // Navigator.of(context).push(
  //   MaterialPageRoute(
  //     builder: (_) => PdfViewerPage(path: path),
  //   ),
  // );
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

class LedgerMetric extends StatelessWidget {
  final String title;
  final String metric;
  final String date;
  final String number;
  final String average;

  LedgerMetric({this.title, this.number, this.date, this.metric, this.average});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DetailCard(title, number, date, metric, average));
  }
}
