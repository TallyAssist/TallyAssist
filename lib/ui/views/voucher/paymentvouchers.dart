import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';



class PaymentVoucherScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {



    return  ListView(
          children: <Widget>[
          PaymentVoucherList()

  ],
    );
  }
}

class PaymentVoucherList extends StatefulWidget {
  @override
  _PaymentVoucherListState createState() => _PaymentVoucherListState();
}

class _PaymentVoucherListState extends State<PaymentVoucherList> {

  
  TextEditingController editingController = TextEditingController();

  Iterable<Voucher> paymentVoucherData;
  List<Voucher> paymentVoucherDataforDisplay= List<Voucher>();

  @override
  void initState() {
    paymentVoucherData = Provider.of<List<Voucher>>(context, listen: false);
    paymentVoucherDataforDisplay.addAll(paymentVoucherData);

    super.initState();
  }

  void filterSearchResults(String query) {
    List<Voucher> dummySearchList = List<Voucher>();
    dummySearchList.addAll(paymentVoucherData);
    if (query.isNotEmpty) {
      List<Voucher> dummyListData = List<Voucher>();
      dummySearchList.forEach((item) {
        if (item.partyname.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        paymentVoucherDataforDisplay.clear();
        paymentVoucherDataforDisplay.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        paymentVoucherDataforDisplay.clear();
        paymentVoucherDataforDisplay.addAll(paymentVoucherData);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    // final paymentVoucherData = Provider.of<List<PaymentVoucher>>(context);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Payment Vouchers: ${paymentVoucherDataforDisplay.length}'),
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
                itemCount: paymentVoucherDataforDisplay?.length ?? 0,
                itemBuilder: (context, index) {
                  return PaymentVoucherTile(paymentVoucher: paymentVoucherDataforDisplay[index]);
                },
              ),
            ),
          ],
        ));
  }
}



class PaymentVoucherTile extends StatelessWidget {

  final Voucher paymentVoucher;

  PaymentVoucherTile({this.paymentVoucher});


  @override
  Widget build(BuildContext context) {
    return  DetailCard(paymentVoucher.partyname, 
    '# ${paymentVoucher.masterid}',
     paymentVoucher.iscancelled, 
     'Rs ${paymentVoucher.amount}', 
     paymentVoucher.date.toString());
  }
}

