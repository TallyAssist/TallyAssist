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
        .orderBy('vdate', descending: true)
        // .endBefore([DateTime(2019, 9, 30)])
        .limit(2000)
        .snapshots()
        .map(_receiptvouchersfromSnapshots);
  }

  Future saveVoucherRecord({
    number,
    masterId,
    date,
    partyMasterId,
    partyname,
    amount,
    primaryVoucherType,
    isInvoice,
    type,
  }) async {
    return await companyCollection
        .document(this.uid)
        .collection('voucher')
        .document(masterId)
        .setData({
      'number': number,
      'masterid': masterId,
      'vdate': date,
      'partyledgername': partyMasterId,
      'restat_party_ledger_name': partyname,
      'amount': amount,
      'primaryvouchertypename': primaryVoucherType,
      'isinvoice': isInvoice,
      'type': type,
      'fromTally': '0',
    });
  }

  List<Voucher> _receiptvouchersfromSnapshots(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Voucher(
        date: doc.data['vdate']?.toDate() ?? null,
        partyname: doc.data['restat_party_ledger_name'] ?? '',
        amount: doc.data['amount']?.toDouble() ?? 0,
        masterid: doc.data['masterid'] ?? '',
        iscancelled: doc.data['iscancelled'] ?? '',
        primaryVoucherType: doc.data['primaryvouchertypename'] ?? '',
        isInvoice: doc.data['isinvoice'] ?? '',
        isPostDated: doc.data['ispostdated'] ?? '',
        reference: doc.data['reference'] ?? '',
        type: doc.data['type'] ?? '',
        partyGuid: doc.data['partyledgername'] ?? '',
        number: doc.data['number'] ?? '',
      );
    }).toList();
  }
}
