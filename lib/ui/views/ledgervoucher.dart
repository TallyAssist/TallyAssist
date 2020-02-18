import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';



class LedgerVoucher extends StatelessWidget {

  final String ledgerId;
  final String partyname;

  LedgerVoucher({this.ledgerId, this.partyname});

  

  @override
  Widget build(BuildContext context) {

    return ListView(
    children: <Widget>[
    VoucherList(ledgerId: ledgerId, partyname: partyname)

  ],
);
  }
}

class VoucherList extends StatefulWidget {
    
    final String ledgerId;
    final String partyname;
    VoucherList({this.ledgerId, this.partyname});

  @override
  _VoucherListState createState() => _VoucherListState(ledgerId, partyname);
}

class _VoucherListState extends State<VoucherList> {

  final String ledgerId;
  final String partyname;
  _VoucherListState(this.ledgerId, this.partyname);

  TextEditingController editingController = TextEditingController();

  Iterable<Voucher> voucherData;
  List<Voucher> voucherDataforDisplay= List<Voucher>();
  

  @override
  void initState() {
    voucherData = Provider.of<List<Voucher>>(context, listen: false).where((voucherData) => voucherData.partyname == partyname);
    voucherDataforDisplay.addAll(voucherData);
   

    super.initState();
  }

  void filterSearchResults(String query) {
    List<Voucher> dummySearchList = List<Voucher>();
    dummySearchList.addAll(voucherData);
    if (query.isNotEmpty) {
      List<Voucher> dummyListData = List<Voucher>();
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

    Iterable<LedgerItem> ledgerItem = Provider.of<List<LedgerItem>>(context).where((item) => item.masterId == ledgerId);
    print(ledgerItem);
    LedgerItem ledger = ledgerItem.elementAt(0);


   
    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
             Padding(
                                padding: spacer.all.xs,
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                Row( children: <Widget> [
                                      Container(
                                          height: 30.0,
                                        child: Text(ledger.name, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(
                                        color: TassistPrimary
                                      ),
                                       )
                                      )
                                ] 
                                ),
                                Row( 
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget> [
                                Text(ledger.gst, style: TextStyle(
                                  color: TassistInfoGrey
                                ),),
                                Icon(FontAwesomeIcons.whatsapp, color: TassistSuccess,)
                                ])
                              ],),
                            ),
                             Container(
                                height: 3.0,
                                color: TassistPrimary
                              ),



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
                  return VoucherTile(voucher: voucherDataforDisplay[index]);
                },
              ),
            ),
          ],
        ));
  }
}



class VoucherTile extends StatelessWidget {

  final Voucher voucher;

  VoucherTile({this.voucher});


  @override
  Widget build(BuildContext context) {
    return  DetailCard('', 
    '# ${voucher.masterid}',
     voucher.primaryVoucherType, 
     'Rs ${voucher.amount}', 
     '${voucher.date}'); 
  }
}


