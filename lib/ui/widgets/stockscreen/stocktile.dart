import 'package:flutter/material.dart';
import 'package:tassist/core/models/stockitem.dart';
import 'package:intl/intl.dart';
import 'package:tassist/core/services/string_format.dart';
import 'package:tassist/ui/widgets/childdetailcard.dart';
import 'package:tassist/ui/widgets/expansibledetailcard.dart';

var formatter = new DateFormat('dd-MM-yyyy');


class StockItemTile extends StatelessWidget {
  final StockItem stockItem;

  StockItemTile({this.stockItem});

  @override
  Widget build(BuildContext context) {
    return ExpansibleDetailCard(
      childdetailCard: ChildDetailCard(
        stockItem.name,
        '# ${stockItem.masterId}',
        'CR: ${formatIndianCurrency(stockItem.closingRate.toString())}',
        '${stockItem.closingBalance.toString()} ${stockItem.baseUnit}',
        'CV: ${formatIndianCurrency(stockItem.closingValue)}',

      ),
      title1: 'Standard Cost',
      info1: '${formatIndianCurrency(stockItem.standardCost.toString())}',
      title2: 'Standard Price',
      info2: '${formatIndianCurrency(stockItem.standardPrice.toString())}',
      title3: 'Minimum Qty.',
      info3: 'Not available',
    );
  }
}
