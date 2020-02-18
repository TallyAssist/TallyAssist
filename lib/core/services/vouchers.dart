import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/vouchers.dart';

class VoucherService {
  final String uid;
  VoucherService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

  Stream<List<Voucher>> get voucherData {
    return companyCollection
        .document(this.uid)
        .collection('voucher')
        .orderBy('date', descending: true)
        .snapshots()
        .map(_receiptvouchersfromSnapshots);
  }

  List<Voucher> _receiptvouchersfromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Voucher(
        date: doc.data['date'].toDate() ?? '',
        partyname: doc.data['restat_party_ledger_name'] ?? '',
        amount: doc.data['amount'].toInt() ?? 0,
        masterid: doc.data['master_id'] ?? '',
        iscancelled: doc.data['is_cancelled'] ?? '',
        primaryVoucherType: doc.data['primary_voucher_type_name'] ?? '',
      );
    }).toList();
  }
}