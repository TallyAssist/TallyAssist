import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/purchasevoucher.dart';

class PurchaseVoucherService {
  final String uid;
  PurchaseVoucherService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

  Stream<List<PurchaseVoucher>> get purchaseVoucherData {
    return companyCollection
        .document(this.uid)
        .collection('voucher')
        .where('primary_voucher_type_name', isEqualTo: 'Purchase')
        .orderBy('amount', descending: true)
        .snapshots()
        .map(_purchasevouchersfromSnapshots);
  }

  List<PurchaseVoucher> _purchasevouchersfromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PurchaseVoucher(
        date: doc.data['date'] ?? '',
        partyname: doc.data['restat_party_ledger_name'] ?? '',
        amount: doc.data['amount'].toInt() ?? 0,
        masterid: doc.data['master_id'] ?? '',
        iscancelled: doc.data['is_cancelled'] ?? '',
      );
    }).toList();
  }
}