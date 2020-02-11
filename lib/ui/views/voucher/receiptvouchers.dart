import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/receiptvoucher.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';



class ReceiptVoucherScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

  // final user = Provider.of<FirebaseUser>(context);

    return ListView(
          children: <Widget>[
          ReceiptVoucherList()

  ],
    );
  }
}

class ReceiptVoucherList extends StatefulWidget {
  @override
  _ReceiptVoucherListState createState() => _ReceiptVoucherListState();
}

class _ReceiptVoucherListState extends State<ReceiptVoucherList> {
  @override
  Widget build(BuildContext context) {
    final receiptVoucherData = Provider.of<List<ReceiptVoucher>>(context);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Receipt Vouchers: ${receiptVoucherData.length}'),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: receiptVoucherData?.length ?? 0,
                itemBuilder: (context, index) {
                  return ReceiptVoucherTile(receiptVoucher: receiptVoucherData[index]);
                },
              ),
            ),
          ],
        ));
  }
}



class ReceiptVoucherTile extends StatelessWidget {

  final ReceiptVoucher receiptVoucher;

  ReceiptVoucherTile({this.receiptVoucher});


  @override
  Widget build(BuildContext context) {
    return  DetailCard(receiptVoucher.partyname, 
    '# ${receiptVoucher.masterid}',
     receiptVoucher.iscancelled, 
     'Rs ${receiptVoucher.amount}', 
     receiptVoucher.date);
  }
}

