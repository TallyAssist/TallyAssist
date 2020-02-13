import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/payables.dart';


class PayablesItemService {
  final String uid;
  PayablesItemService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');


        Stream<List<PayablesItem>> get accountsPayablesData {
    return companyCollection
        .document(this.uid)
        .collection('ledger')
        .where('restat_total_payables', isGreaterThan: 0)
        .orderBy('restat_total_payables', descending: true)
        .snapshots()
        .map(_payablesItemData);
  }

  List<PayablesItem> _payablesItemData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return PayablesItem(
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
        guid: doc.data['guid'] ?? '',
        lastPaymentDate: doc.data['restat_last_payment_date'] ?? '',
          lastPurchaseDate: doc.data['restat_last_purchase_date'] ?? '',
          lastReceiptDate: doc.data['restat_last_receipt_date'] ?? '',
          lastSalesDate: doc.data['restat_last_sales_date'] ?? '',
          meanPayment: doc.data['restat_mean_payment'].toString()?? '',
          meanPurchase: doc.data['restat_mean_purchase'].toString() ?? '',
          meanReceipt: doc.data['restat_mean_receipt'].toString() ?? '',
          meanSales: doc.data['restat_mean_sales'].toString() ?? '',
          partyGuid: doc.data['restat_party_guid'].toString() ?? '',
          totalPayables: doc.data['restat_total_payables'].toString() ?? '',
          totalPayment: doc.data['restat_total_payment'].toString() ?? '',
          totalPurchase: doc.data['restat_total_purchase'].toString() ?? '',
          totalReceipt: doc.data['restat_total_receipt'].toString() ?? '',
          totalReceivables: doc.data['restat_total_receivables'].toString() ?? '',
      );
    }).toList();
  }
}
