import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/ledgervoucher.dart';

class LedgerVoucherService {
  final String uid;
  // final String ledgerId;
  final String partyName;

  LedgerVoucherService({this.uid, this.partyName});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

  Stream<List<LedgerVoucherModel>> get ledgerVoucherData {
    return companyCollection
        .document(this.uid)
        .collection('voucher')
        .where('restat_party_ledger_name', isEqualTo: partyName)
        .orderBy('date', descending: true)
        .snapshots()
        .map(_ledgervoucherdata);
  }

  List<LedgerVoucherModel> _ledgervoucherdata(QuerySnapshot snapshot) {
    return snapshot.documents.map(
      (doc) {
        return LedgerVoucherModel(
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
          ledgerEntries: doc.data['ledger_entries'] ?? [],
          inventoryEntries: doc.data['inventory_entries'] != ''
              ? (doc.data['inventory_entries'] ?? [])
              : [0],
        );
      },
    ).toList();
  }
}
