import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/receiptvoucher.dart';

class ReceiptVoucherService {
  final String uid;
  ReceiptVoucherService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

  Stream<List<ReceiptVoucher>> get receiptVoucherData {
    return companyCollection
        .document(this.uid)
        .collection('voucher')
        .where('primary_voucher_type_name', isEqualTo: 'Receipt')
        .orderBy('amount', descending: true)
        .snapshots()
        .map(_receiptvouchersfromSnapshots);
  }

  List<ReceiptVoucher> _receiptvouchersfromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ReceiptVoucher(
        date: doc.data['date'] ?? '',
        partyname: doc.data['restat_party_ledger_name'] ?? '',
        amount: doc.data['amount'].toInt() ?? 0,
        masterid: doc.data['master_id'] ?? '',
        iscancelled: doc.data['is_cancelled'] ?? '',
      );
    }).toList();
  }
}