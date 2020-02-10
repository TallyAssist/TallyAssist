import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/ledger.dart';

class LedgerItemService {
  final String uid;
  LedgerItemService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

      Stream<List<LedgerItem>> get inactiveCustomerData {
    return companyCollection
        .document(this.uid)
        .collection('ledger')
        .where('closing_balance', isEqualTo: 0)
        .snapshots()
        .map(_ledgerItemData);
  }

  Stream<List<LedgerItem>> get ledgerItemData {
    return companyCollection
        .document(this.uid)
        .collection('ledger')
        .orderBy('name', descending: false)
        .snapshots()
        .map(_ledgerItemData);
  }

  List<LedgerItem> _ledgerItemData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return LedgerItem(
        name: doc.data['name'] ?? '',
        masterId: doc.data['master_id'] ?? '',
        currencyName: doc.data['currencyname'] ?? '',
        openingBalance: doc.data['opening_balance'].toString() ?? '',
        closingBalance: doc.data['closing_balance'].toString() ?? '',
        parentid: doc.data['parentcode'] ?? '',
        contact: doc.data['contact'] ?? '',
        state: doc.data['state'] ?? '',
        email: doc.data['email'] ?? '',
        phone: doc.data['phone'] ?? '',
      );
    }).toList();
  }
}
