import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/paymentvoucher.dart';
import 'package:tassist/core/services/paymentvoucherservice.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/detailcard.dart';



class PaymentVoucherScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

  final user = Provider.of<FirebaseUser>(context);

    return StreamProvider<List<PaymentVoucher>>.value (
          value: PaymentVoucherService(uid: user.uid).paymentVoucherData,
          child:  ListView(
          children: <Widget>[
          PaymentVoucherList()

  ],
)
    );
  }
}

class PaymentVoucherList extends StatefulWidget {
  @override
  _PaymentVoucherListState createState() => _PaymentVoucherListState();
}

class _PaymentVoucherListState extends State<PaymentVoucherList> {
  @override
  Widget build(BuildContext context) {
    final paymentVoucherData = Provider.of<List<PaymentVoucher>>(context);

    return Container(
        height: MediaQuery.of(context).size.height / 1.1,
        child: Column(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: Text('Total Payment Vouchers: ${paymentVoucherData.length}'),
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: paymentVoucherData?.length ?? 0,
                itemBuilder: (context, index) {
                  return PaymentVoucherTile(paymentVoucher: paymentVoucherData[index]);
                },
              ),
            ),
          ],
        ));
  }
}



class PaymentVoucherTile extends StatelessWidget {

  final PaymentVoucher paymentVoucher;

  PaymentVoucherTile({this.paymentVoucher});


  @override
  Widget build(BuildContext context) {
    return  DetailCard(paymentVoucher.partyname, 
    '# ${paymentVoucher.masterid}',
     paymentVoucher.iscancelled, 
     'Rs ${paymentVoucher.amount}', 
     paymentVoucher.date);
  }
}

