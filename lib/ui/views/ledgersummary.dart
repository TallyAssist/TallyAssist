import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/services/string_format.dart';
import 'package:tassist/ui/shared/debitcredit.dart';


var formatter = new DateFormat('dd-MM-yyyy');

_formatDate(DateTime date) {
  if (date != null) {
    return formatter.format(date);
  } else {
    return 'NA';
  }
}

class LedgerSummary extends StatelessWidget {
  final String ledgerGuid;

  LedgerSummary({this.ledgerGuid});

  @override
  Widget build(BuildContext context) {
    Iterable<LedgerItem> ledgerItem = Provider.of<List<LedgerItem>>(context)
            .where((item) => item.guid == ledgerGuid) ??
        [];
    LedgerItem ledger = ledgerItem.elementAt(0) ?? [];

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
                        height: 30.0,
                        child: Text(
                          ledger.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
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
                        Icon(
                          FontAwesomeIcons.whatsapp,
                          color: TassistSuccess,
                        )
                      ])
                ],
              ),
            ),
            Container(height: 3.0, color: TassistPrimary),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5.0,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: spacer.all.xxs,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Receivables'),
                          Text(formatIndianCurrency(ledger.totalReceivables))
                        ],
                      ),
                    ),
                    Padding(
                      padding: spacer.all.xxs,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Payables'),
                          Text(formatIndianCurrency(ledger.totalPayables))
                        ],
                      ),
                    ),
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
            ),
            LedgerMetric(
                title: 'Sales',
                number: 'Bills: ${ledger.numSalesVouchers}',
                date: 'Last: ${_formatDate(ledger.lastSalesDate)}',
                metric: 'Total: ${formatIndianCurrency(ledger.totalSales)}',
                average: 'Average: ${formatIndianCurrency(ledger.meanSales)}'),
            LedgerMetric(
                title: 'Receipts',
                number: 'Bills: ${ledger.numReceiptVouchers}',
                date: 'Last: ${_formatDate(ledger.lastReceiptDate)}',
                metric: 'Total: ${formatIndianCurrency(ledger.totalReceipt)}',
                average: 'Average: ${formatIndianCurrency(ledger.meanReceipt)}'),
            LedgerMetric(
                title: 'Purchases',
                number: 'Bills: ${ledger.numPurchaseVouchers}',
                date: 'Last: ${_formatDate(ledger.lastPurchaseDate)}',
                metric: 'Total: ${formatIndianCurrency(ledger.totalPurchase)}',
                average: 'Average: ${formatIndianCurrency(ledger.meanPurchase)}'),
            LedgerMetric(
                title: 'Payment',
                number: 'Bills: ${ledger.numPaymentVouchers}',
                date: 'Last: ${_formatDate(ledger.lastPaymentDate)}',
                metric: 'Total: ${formatIndianCurrency(ledger.totalPayment)}',
                average: 'Average: ${formatIndianCurrency(ledger.meanPayment)}'),
          ]),
        ));
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
