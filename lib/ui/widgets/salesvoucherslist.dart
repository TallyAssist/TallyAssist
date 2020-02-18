import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/salesvoucher.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/widgets/salesvouchertile.dart';

class SalesVoucherList extends StatefulWidget {
  @override
  _SalesVoucherListState createState() => _SalesVoucherListState();
}

class _SalesVoucherListState extends State<SalesVoucherList> {
  TextEditingController editingController = TextEditingController();

  List<SalesVoucher> salesVoucherData;
  List<SalesVoucher> salesVoucherDataforDisplay = List<SalesVoucher>();

  @override
  void initState() {
    salesVoucherData = Provider.of<List<SalesVoucher>>(context, listen: false);
    salesVoucherDataforDisplay.addAll(salesVoucherData);

    super.initState();
  }

  void filterSearchResults(String query) {
    List<SalesVoucher> dummySearchList = List<SalesVoucher>();
    dummySearchList.addAll(salesVoucherData);
    if (query.isNotEmpty) {
      List<SalesVoucher> dummyListData = List<SalesVoucher>();
      dummySearchList.forEach((item) {
        if (item.partyname.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        salesVoucherDataforDisplay.clear();
        salesVoucherDataforDisplay.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        salesVoucherDataforDisplay.clear();
        salesVoucherDataforDisplay.addAll(salesVoucherData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final salesVoucherData  = Provider.of<List<SalesVoucher>>(context);

    return Container(
        height: MediaQuery.of(context).size.height,
        child: Column(children: <Widget>[
          Padding(
            padding: spacer.all.xxs,
            child: Text(
                'Total Sales Vouchers: ${salesVoucherDataforDisplay?.length}'),
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
              shrinkWrap: false,
              itemCount: salesVoucherDataforDisplay?.length ?? 0,
              itemBuilder: (context, index) {
                return SalesVoucherTile(
                    salesVoucher: salesVoucherDataforDisplay[index]);
              },
            ),
          )
        ]));
  }
}
