import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/paymentvoucher.dart';


class PaymentVoucherService {
  final String uid;
  PaymentVoucherService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

  Stream<List<PaymentVoucher>> get paymentVoucherData {
    return companyCollection
        .document(this.uid)
        .collection('voucher')
        .where('primary_voucher_type_name', isEqualTo: 'Payment')
        .orderBy('amount', descending: true)
        .snapshots()
        .map(_purchasevouchersfromSnapshots);
  }

  List<PaymentVoucher> _purchasevouchersfromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PaymentVoucher(
        date: doc.data['date'] ?? '',
        partyname: doc.data['restat_party_ledger_name'] ?? '',
        amount: doc.data['amount'].toDouble() ?? 0,
        masterid: doc.data['master_id'] ?? '',
        iscancelled: doc.data['is_cancelled'] ?? '',
      );
    }).toList();
  }
}