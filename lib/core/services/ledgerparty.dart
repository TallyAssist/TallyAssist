import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/ledgerparty.dart';

class LedgerPartyService {
  final String uid;

  final String voucherId;

  LedgerPartyService({this.uid, this.voucherId});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

  Stream<List<LedgerParty>> get voucherLedgerData {
    return companyCollection
        .document(this.uid)
        .collection('ledger_entries')
        .where('restat_voucher_master_id', isEqualTo: voucherId)
        .snapshots()
        .map(_voucherLedgerData);
  }

  List<LedgerParty> _voucherLedgerData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return LedgerParty(
        amount: doc.data['amount'].toDouble() ?? 0,
        isDeemedPositive: doc.data['isdeemedpositive'].toString() ?? '',
        isPartyLedger: doc.data['ispartyledger'].toString() ?? '',
        ledgerGuid: doc.data['ledger_guid'].toString() ?? '',
        ledgerMasterId: doc.data['ledgername'].toString() ?? '',
        ledgerRefMasterId: doc.data['ledgerrefname'].toString() ?? '',
        // primaryVoucherType:
        //     doc.data['primary_voucher_type_name'].toString() ?? '',
        primaryGroup: doc.data['primarygroup'].toString() ?? '',
        ledgerName: doc.data['restat_ledger_name'].toString() ?? '',
        ledgerRefName: doc.data['restat_ledger_ref_name'].toString() ?? '',
        partyName: doc.data['restat_party_ledger_name'].toString() ?? '',
        date: doc.data['restat_voucher_date'].toDate() ?? null,
        voucherMasterID: doc.data['restat_voucher_master_id'].toString() ?? '',
      );
    }).toList();
  }
}
