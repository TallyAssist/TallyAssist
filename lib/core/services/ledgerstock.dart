import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/ledgerstock.dart';


class LedgerStockService {
  final String uid;
  final String ledgerId;

  LedgerStockService({this.uid, this.ledgerId});

   final CollectionReference companyCollection =
      Firestore.instance.collection('company');

    Stream<List<LedgerStock>> get ledgerStockData {
    return companyCollection
        .document(this.uid)
        .collection('ledger')
        .document(this.ledgerId)
        .collection('ledger_stock_metrics')
        .snapshots()
        .map(_ledgerstockdata);
  }

  


  List<LedgerStock> _ledgerstockdata(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return LedgerStock(
          lastAmount: doc.data['total_amount'].toString() ?? '',
          lastDiscount: doc.data['last_discount'].toString() ?? '',
          lastRate: doc.data['last_rate'].toString() ?? '',
          lastDate: doc.data['last_voucher_date'].toDate() ?? null,
          itemName: doc.data['restat_stock_item_name'].toString() ?? '',
          totalAmount: doc.data['total_amount'].toString() ?? '',
          totalActualQty: doc.data['total_actualqty'].toString() ?? '',
          totalBilledQty: doc.data['total_billedqty'].toInt() ?? 0,
          numVouchers: doc.data['num_vouchers'].toString() ?? '',
      );
    }).toList();
  }
}