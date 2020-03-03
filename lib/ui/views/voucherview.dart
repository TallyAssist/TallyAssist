import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/voucher-item.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tassist/core/services/voucher-item-service.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/services/ledgerparty.dart';
import 'package:tassist/core/models/ledgerparty.dart';
import 'package:tassist/core/services/string_format.dart';
import 'package:tassist/ui/shared/positiveamount.dart';
import 'package:tassist/ui/shared/debitcredit.dart';

var formatter = new DateFormat('dd-MM-yyyy') ?? null;

class VoucherView extends StatelessWidget {
  VoucherView({this.voucherId, this.partyGuid});

  final String partyGuid;
  final String voucherId;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    Iterable<Voucher> voucherList = Provider.of<List<Voucher>>(context)
            .where((item) => item.masterid == voucherId) ??
        [];
    Voucher voucher = voucherList.elementAt(0) ?? [];

    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return MultiProvider(
      providers: [
        StreamProvider<List<VoucherItem>>.value(
          value: VoucherItemService(uid: user?.uid, voucherId: voucherId)
              .voucherItemData,
        ),
        StreamProvider<List<LedgerParty>>.value(
          value: LedgerPartyService(uid: user?.uid, voucherId: voucherId)
              .voucherLedgerData,
        ),
      ],
      child: WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
              key: _drawerKey,
              drawer: tassistDrawer(context),
              appBar: headerNavOtherVoucher(_drawerKey, context, voucher),
              body: SingleChildScrollView(
                              child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: spacer.all.xxs,
                        child: Text(
                          voucher.partyname,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        
                      ),
                      Text(voucher.number),
                      Container(height: 3.0, color: TassistGray),
                      Padding(
                        padding: spacer.all.xxs,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: spacer.all.xxs,
                              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: TassistBgLightPurple,
                              ),
                              child: Text(voucher.primaryVoucherType),
                            ),
                            // SizedBox(width: 20),
                            Text(voucher.type),
                            _isInvoice(voucher),
                          ],
                        ),
                      ),
                      Padding(
                        padding: spacer.all.xxs,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                Text(
                    formatIndianCurrency(
                            positiveAmount(voucher.amount)
                                .toString()) ??
                        '',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold)),
                Text('Amount')
                              ],
                            ),
                            Column(
                              children: <Widget>[
                Text(formatter.format(voucher.date) ?? 'NA',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold)),
                Text('Date')
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: spacer.all.xxs,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Reference: ${voucher.reference}' ?? '')
                            ]),
                      ),
                      Container(height: 3.0, color: TassistGray),
                      Container(
                          child: VoucherItemView()),

                      LedgerPartyView(),
                      //  Container(
                      //   height: 3.0,
                      //   color: TassistGray
                      // ),
                      // Text('Total Invoice: ${voucher.amount}', style: Theme.of(context).textTheme.bodyText2,)
                    ],
                  ),
              )
            )
          ),
    );
  }
}


// Tax summary
class LedgerPartyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<LedgerParty> ledgerPartyList =
        Provider.of<List<LedgerParty>>(context) ?? [];

    if (ledgerPartyList.length > 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Ledger Summary'),
          ListView.builder(
              shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
              itemCount: ledgerPartyList?.length,
              itemBuilder: (context, index) {
                return LedgerPartyTile(ledgerParty: ledgerPartyList[index]);
              }),
          Container(height: 3.0, color: TassistGray),
        ],
      );
    } else {
      return Container();
    }
  }
}

class LedgerPartyTile extends StatelessWidget {
  LedgerPartyTile({this.ledgerParty});

  final LedgerParty ledgerParty;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                ledgerParty.ledgerName,
                overflow: TextOverflow.ellipsis,
              )),
          Text(debitCredit(ledgerParty.amount)),
        ],
      ),
    );
  }
}

// Item Summary

class VoucherItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<VoucherItem> voucherItemList =
        Provider.of<List<VoucherItem>>(context) ?? [];


    if (voucherItemList.length > 0) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Item Details'),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: voucherItemList?.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: spacer.y.xxs,
                  child: VoucherItemTile(voucherItem: voucherItemList[index]),
                );
              }),
          Container(height: 3.0, color: TassistGray),
        ],
      );
    } else {
      return Container();
    }
  }
}

class VoucherItemTile extends StatelessWidget {
  VoucherItemTile({this.voucherItem});

  final VoucherItem voucherItem;

  @override
  Widget build(BuildContext context) {
    return DetailCard(
        voucherItem.stockItemName,
        '${positiveAmount(voucherItem.billedQty)} Qty @ ${voucherItem.rate}/item',
        'GST @ ${voucherItem.gstPercent}%: ${formatIndianCurrency(voucherItem.taxAmount.toString())}',
        'Amount: ${formatIndianCurrency(positiveAmount(voucherItem.amount).toString())}',
        'Discount: ${voucherItem.discount}');
  }
}

_isInvoice(Voucher voucher) {
  if (voucher.isInvoice == '1') {
    return Text('Invoice',
        style: TextStyle(
          color: TassistBgPurple,
          fontWeight: FontWeight.bold,
        ));
  } else {
    return Container();
  }
}

AppBar headerNavOtherVoucher(GlobalKey<ScaffoldState> _drawerkey,
    BuildContext context, Voucher voucher) {
  bool enabled = true;

  return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 12),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (enabled) {
              Navigator.pop(context);
              // Navigator.of(context).pushReplacement(
              //   MaterialPageRoute(
              //     builder: (context) => LedgerView(
              //       partyname: voucher.partyname,
              //       ledgerGuid: voucher.partyGuid,
              //     ),
              //   ),
              // );
            }
          },
        ),
      ),
      elevation: 0.7,
      title: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'TallyAssist',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const Text(
                'Beta',
                style: TextStyle(
                  color: TassistWhite,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          Spacer(),
          Text(
            'Help?',
            style: TextStyle(fontSize: 14.0, letterSpacing: 1.0),
          ),
          IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp),
              onPressed: () => _launchURL())
          // DropDownMonths(),
        ],
      ),
      backgroundColor: TassistMenuBg);
}

_launchURL() async {
  const url = 'https://api.whatsapp.com/send?phone=+917759091029';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
