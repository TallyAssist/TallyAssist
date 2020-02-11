import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/purchasevoucher.dart';
import 'package:tassist/core/services/purchasevoucherservice.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';



class PurchaseVoucherScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

  final user = Provider.of<FirebaseUser>(context);

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
  @override
  Widget build(BuildContext context) {
    final purchaseVoucherData = Provider.of<List<PurchaseVoucher>>(context);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Purchase Vouchers: ${purchaseVoucherData?.length}'),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: purchaseVoucherData?.length ?? 0,
                itemBuilder: (context, index) {
                  return PurchaseVoucherTile(purchaseVoucher: purchaseVoucherData[index]);
                },
              ),
            ),
          ],
        ));
  }
}



class PurchaseVoucherTile extends StatelessWidget {

  final PurchaseVoucher purchaseVoucher;

  PurchaseVoucherTile({this.purchaseVoucher});


  @override
  Widget build(BuildContext context) {
    return  DetailCard(purchaseVoucher.partyname, 
    '# ${purchaseVoucher.masterid}',
     purchaseVoucher.iscancelled, 
     'Rs ${purchaseVoucher.amount}', 
     '${purchaseVoucher.date}');
  }
}


