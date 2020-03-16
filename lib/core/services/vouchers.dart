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
        .endBefore([DateTime(2019, 9, 30)])
        // .limit(1000)
        .snapshots()
        .map(_receiptvouchersfromSnapshots);
  }

  List<Voucher> _receiptvouchersfromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Voucher(
        date: doc.data['date'].toDate() ?? null,
        partyname: doc.data['restat_party_ledger_name'] ?? '',
        amount: doc.data['amount']?.toDouble() ?? 0,
        masterid: doc.data['master_id'] ?? '',
        iscancelled: doc.data['is_cancelled'] ?? '',
        primaryVoucherType: doc.data['primary_voucher_type_name'] ?? '',
        isInvoice: doc.data['is_invoice'] ?? '',
        isPostDated: doc.data['is_post_dated'] ?? '',
        reference: doc.data['reference'] ?? '',
        type: doc.data['type'] ?? '',
        partyGuid: doc.data['party_ledger_name'] ?? '',
        number: doc.data['number'] ?? '',
      );
    }).toList();
  }
}
