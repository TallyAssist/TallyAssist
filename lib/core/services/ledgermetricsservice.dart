import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/ledgermetrics.dart';



class LedgerMetricsService {
  final String uid;
  LedgerMetricsService({this.uid});

  final CollectionReference metricsCollection =
      Firestore.instance.collection('metrics');



  Stream<List<LedgerMetrics>> get ledgerMetricsData {
    return metricsCollection
        .document(this.uid)
        .collection('ledgermetrics')
        .orderBy('name', descending: false)
        .snapshots()
        .map(_ledgerMetricsData);
  }

  List<LedgerMetrics> _ledgerMetricsData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return LedgerMetrics(
          lastPaymentDate: doc.data['last_payment_date'] ?? '',
          lastPurchaseDate: doc.data['last_purchase_date'] ?? '',
          lastReceiptDate: doc.data['last_receipt_date'] ?? '',
          lastSalesDate: doc.data['last_sales_date'] ?? '',
          meanPayment: doc.data['mean_payment'] ?? '',
          meanPurchase: doc.data['mean_purchase'] ?? '',
          meanReceipt: doc.data['mean_receipt'] ?? '',
          meanSales: doc.data['mean_sales'] ?? '',
          partyGuid: doc.data['party_guid'] ?? '',
          totalPayables: doc.data['total_payables'] ?? '',
          totalPayment: doc.data['total_payment'] ?? '',
          totalPurchase: doc.data['total_purchase'] ?? '',
          totalReceipt: doc.data['total_receipt'] ?? '',
          totalReceivables: doc.data['total_receivables'] ?? '',
      );
    }).toList();
  }
}
