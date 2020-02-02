import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/salesvoucher.dart';
import 'package:tassist/ui/widgets/salesvouchertile.dart';

class SalesVoucherList extends StatefulWidget {
  @override
  _SalesVoucherListState createState() => _SalesVoucherListState();
}

class _SalesVoucherListState extends State<SalesVoucherList> {
  @override
  Widget build(BuildContext context) {

  final salesVoucherData  = Provider.of<List<SalesVoucher>>(context);

    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: false,
        itemCount: salesVoucherData.length ?? '',
        itemBuilder: (context, index) {
          return SalesVoucherTile(salesVoucher: salesVoucherData[index]);
        },
      ),
      
    );
  }
}