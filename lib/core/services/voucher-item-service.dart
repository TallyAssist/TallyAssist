import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/voucher-item.dart';


class VoucherItemService {
  final String uid;
  final String voucherId;

  VoucherItemService({this.uid, this.voucherId,});

   final CollectionReference companyCollection =
      Firestore.instance.collection('company');

    Stream<List<VoucherItem>> get voucherItemData {
    return companyCollection
        .document(this.uid)
        .collection('inventory_entries')
        .where('voucher_master_id', isEqualTo: voucherId)
        .snapshots()
        .map(_voucherItemData);
  }

  


  List<VoucherItem> _voucherItemData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return VoucherItem(
          stockItemName: doc.data['restat_stock_item_name'].toString() ?? '',
          partyLedgerName: doc.data['restat_party_ledger_name'].toString() ?? '',
          vDate: doc.data['voucher_date'].toDate() ?? null,
          vMasterId: doc.data['voucher_master_id'].toString() ?? '',
          rate: doc.data['rate'].toString() ?? '',
          primaryVoucherType: doc.data['primary_voucher_type_name'].toString() ?? '',
          discount: doc.data['discount'].toString() ?? '',
          gstPercent: doc.data['gstpercent'].toString() ?? '',
          billedQty: doc.data['billedqty'].toInt() ?? 0,
          actualQty: doc.data['actualqty'].toString() ?? '',
          amount: doc.data['amount'].toInt() ?? 0,
          taxAmount: doc.data['taxamount'].toString() ?? '',
      );
    }).toList();
  }
}