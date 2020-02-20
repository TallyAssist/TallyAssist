import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:intl/intl.dart';

var formatter = new DateFormat('dd-MM-yyyy');

 _formatDate(DateTime date) {
  if (date != null) {
    return formatter.format(date);
  }
  else {
    return 'NA';
  }

}


class PurchaseVoucherScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

  // final user = Provider.of<FirebaseUser>(context);

    return ListView(
    children: <Widget>[
    PurchaseVoucherList()

  ],
);
  }
}

class PurchaseVoucherList extends StatefulWidget {
  @override
  _PurchaseVoucherListState createState() => _PurchaseVoucherListState();
}

class _PurchaseVoucherListState extends State<PurchaseVoucherList> {

  TextEditingController editingController = TextEditingController();

  Iterable<Voucher> purchaseVoucherData;
  List<Voucher> purchaseVoucherDataforDisplay= List<Voucher>();

  @override
  void initState() {
    purchaseVoucherData = Provider.of<List<Voucher>>(context, listen: false).where((voucher) => voucher.primaryVoucherType == 'Purchase');
    purchaseVoucherDataforDisplay.addAll(purchaseVoucherData);

    super.initState();
  }

  void filterSearchResults(String query) {
    List<Voucher> dummySearchList = List<Voucher>();
    dummySearchList.addAll(purchaseVoucherData);
    if (query.isNotEmpty) {
      List<Voucher> dummyListData = List<Voucher>();
      dummySearchList.forEach((item) {
        if (item.partyname.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        purchaseVoucherDataforDisplay.clear();
        purchaseVoucherDataforDisplay.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        purchaseVoucherDataforDisplay.clear();
        purchaseVoucherDataforDisplay.addAll(purchaseVoucherData);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    // final purchaseVoucherData = Provider.of<List<PurchaseVoucher>>(context);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Purchase Vouchers: ${purchaseVoucherDataforDisplay?.length}'),
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
                        hintText: "Search by party name...",
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
                itemCount: purchaseVoucherDataforDisplay?.length ?? 0,
                itemBuilder: (context, index) {
                  return PurchaseVoucherTile(purchaseVoucher: purchaseVoucherDataforDisplay[index]);
                },
              ),
            ),
          ],
        ));
  }
}



class PurchaseVoucherTile extends StatelessWidget {

  final Voucher purchaseVoucher;

  PurchaseVoucherTile({this.purchaseVoucher});


  @override
  Widget build(BuildContext context) {
    return  DetailCard(purchaseVoucher.partyname, 
    '# ${purchaseVoucher.masterid}',
     purchaseVoucher.iscancelled, 
     'Rs ${purchaseVoucher.amount}', 
     _formatDate(purchaseVoucher.date));
  }
}


