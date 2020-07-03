import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/core/models/ledgervoucher.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/services/string_format.dart';
import 'package:tassist/ui/shared/positiveamount.dart';

var formatter = new DateFormat('dd-MM-yyyy') ?? null;

class LedgerVoucher extends StatelessWidget {
  final String ledgerGuid;
  final String partyname;
  final String timePeriod;

  LedgerVoucher({this.ledgerGuid, this.partyname, this.timePeriod});

  @override
  Widget build(BuildContext context) {
    

    return ListView(
      children: <Widget>[
        VoucherList(
            ledgerGuid: ledgerGuid,
            partyname: partyname,
            timePeriod: timePeriod)
      ],
    );
  }
}

class VoucherList extends StatefulWidget {
  final String ledgerGuid;
  final String partyname;
  final String timePeriod;
  VoucherList({this.ledgerGuid, this.partyname, this.timePeriod});

  @override
  _VoucherListState createState() => _VoucherListState(ledgerGuid, partyname);
}

class _VoucherListState extends State<VoucherList> {
  final String ledgerGuid;
  final String partyname;
  _VoucherListState(this.ledgerGuid, this.partyname);

  TextEditingController editingController = TextEditingController();

  List<LedgerVoucherModel> voucherData;
  List<LedgerVoucherModel> voucherDataforDisplay = List<LedgerVoucherModel>();

  String uid;

  @override
  void initState() {
    uid = Provider.of<FirebaseUser>(context, listen: false).uid;

    // Get all vouchers for current party/ledger
    voucherData = Provider.of<List<LedgerVoucherModel>>(context, listen: false);
        // .where((voucherData) => voucherData.partyname == partyname);
    // voucherData = filterVouchersByTimePeriod(voucherData, widget.timePeriod);
    voucherDataforDisplay.addAll(voucherData);

    super.initState();
  }

  void filterSearchResults(String query) {
    List<LedgerVoucherModel> dummySearchList = List<LedgerVoucherModel>();
    dummySearchList.addAll(voucherData);
    if (query.isNotEmpty) {
      List<LedgerVoucherModel> dummyListData = List<LedgerVoucherModel>();
      dummySearchList.forEach((item) {
        if (item.primaryVoucherType.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        voucherDataforDisplay.clear();
        voucherDataforDisplay.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        voucherDataforDisplay.clear();
        voucherDataforDisplay.addAll(voucherData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Iterable<LedgerItem> ledgerItem = Provider.of<List<LedgerItem>>(context)
        .where((item) => item.guid == ledgerGuid);
    LedgerItem ledger = ledgerItem.elementAt(0);

    String voucherIdView;
    String partyGuid;

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xs,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                        // height: 30.0,
                        width: MediaQuery.of(context).size.width/1.1,
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
                        
                        
                      ])
                ],
              ),
            ),
            Container(height: 3.0, color: TassistPrimary),
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total  Vouchers: ${voucherDataforDisplay?.length}'),
            ),
            Container(
              padding: spacer.bottom.xs,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50.0,
                  child: TextField(
                    onChanged: (value) {
                      filterSearchResults(value.toLowerCase());
                    },
                    controller: editingController,
                    style: Theme.of(context).textTheme.bodyText2,
                    enableSuggestions: true,
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search by type...",
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      labelStyle: Theme.of(context).textTheme.bodyText2,
                      counterStyle: Theme.of(context).textTheme.bodyText2,
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: voucherDataforDisplay?.length ?? 0,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onDoubleTap: () => {
                        voucherIdView = voucherDataforDisplay[index]?.masterid,
                        partyGuid = voucherDataforDisplay[index]?.partyGuid,
                        print(voucherIdView),
                        print(partyGuid),
                        Navigator.pushNamed(
                          context,
                          '/voucherview',
                          arguments: {
                            'voucher_id_view': voucherIdView,
                            'party_guid': partyGuid,
                          },
                        ),
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(
                        //         builder: (context) => VoucherView(
                        //             voucherId: voucherIdView,
                        //             partyGuid: partyGuid)))
                      },
                      child: VoucherTile(voucher: voucherDataforDisplay[index]),
                    );
                  }),
            ),
          ],
        ));
  }
}

class VoucherTile extends StatelessWidget {
  final LedgerVoucherModel voucher;

  VoucherTile({this.voucher});

  @override
  Widget build(BuildContext context) {
    return DetailCard(
        '',
        '# ${voucher.number}',
        voucher.primaryVoucherType,
        formatIndianCurrency(positiveAmount(voucher.amount).toString()),
        formatter.format(voucher.date));
  }
}
