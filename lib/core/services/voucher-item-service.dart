import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/voucher-item.dart';

class VoucherItemService {
  final String uid;
  final String voucherId;

  VoucherItemService({
    this.uid,
    this.voucherId,
  });

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

  Future saveVoucherItemRecord({
    stockItemName,
    partyLedgerName,
    vdate,
    vMasterId,
    rate,
    primaryVoucherType,
    gstPercent,
    billedQty,
    actualqty,
    amount,
    taxAmount,
  }) async {
    return await companyCollection
        .document(this.uid)
        .collection('inventory_entries')
        .document()
        .setData({
      'restat_stock_item_name': stockItemName,
      'restat_party_ledger_name': partyLedgerName,
      'restat_voucher_date': vdate,
      'restat_voucher_master_id': vMasterId,
      'rate': rate,
      'restat_primary_voucher_type_name': primaryVoucherType,
      'gstpercent': gstPercent,
      'billedqty': billedQty,
      'actualQty': actualqty,
      'amount': amount,
      'taxamount': taxAmount,
    });
  }

  List<VoucherItem> _voucherItemData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return VoucherItem(
        stockItemName: doc.data['restat_stock_item_name'].toString() ?? '',
        partyLedgerName: doc.data['restat_party_ledger_name'].toString() ?? '',
        vDate: doc.data['restat_voucher_date'].toDate() ?? null,
        vMasterId: doc.data['restat_voucher_master_id'].toString() ?? '',
        rate: doc.data['rate'].toString() ?? '',
        primaryVoucherType:
            doc.data['restat_primary_voucher_type_name'].toString() ?? '',
        discount: doc.data['discount'].toString() ?? '',
        gstPercent: doc.data['gstpercent'].toString() ?? '',
        billedQty: doc.data['billedqty'].toDouble() ?? 0,
        actualQty: doc.data['actualqty'].toString() ?? '',
        amount: doc.data['amount'].toDouble() ?? 0,
        taxAmount: doc.data['taxamount'].toString() ?? '',
      );
    }).toList();
  }
}
