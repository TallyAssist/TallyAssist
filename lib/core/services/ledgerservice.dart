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
        .where('parentcode', isEqualTo: '20')
        .snapshots()
        .map(_ledgerItemData);
  }

  Stream<List<LedgerItem>> get accountsReceivableData {
    return companyCollection
        .document(this.uid)
        .collection('ledger')
        .where('restat_total_receivables', isLessThan: 0)
        .snapshots()
        .map(_ledgerItemData);
  }

  Stream<List<LedgerItem>> get accountsPayablesData {
    return companyCollection
        .document(this.uid)
        .collection('ledger')
        .where('restat_total_payables', isGreaterThan: 0)
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

  Future saveLedger({masterId, name, phone, gst, partyType}) async {
    return await companyCollection
        .document(this.uid)
        .collection('ledger')
        .document(masterId)
        .setData({
      'name': name,
      'phone': phone,
      'gst': gst,
      'party_type': partyType,
    });
  }

  List<LedgerItem> _ledgerItemData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return LedgerItem(
        name: doc.data['name']?.toString() ?? '',
        masterId: doc.data['master_id']?.toString() ?? '',
        currencyName: doc.data['currencyname']?.toString() ?? '',
        openingBalance: doc.data['opening_balance']?.toDouble() ?? 0,
        closingBalance: doc.data['closing_balance']?.toDouble() ?? 0,
        parentid: doc.data['parentcode']?.toString() ?? '',
        contact: doc.data['contact']?.toString() ?? '',
        address: doc.data['address']?.toString() ?? '',
        pincode: doc.data['pincode']?.toString() ?? '',
        state: doc.data['state']?.toString() ?? '',
        email: doc.data['email']?.toString() ?? '',
        phone: doc.data['phone']?.toString() ?? '',
        guid: doc.data['guid']?.toString() ?? '',
        gst: doc.data['gst']?.toString() ?? '',
        lastPaymentDate: doc.data['restat_last_payment_date']?.toDate() ?? null,
        lastPurchaseDate:
            doc.data['restat_last_purchase_date']?.toDate() ?? null,
        lastReceiptDate: doc.data['restat_last_receipt_date']?.toDate() ?? null,
        lastSalesDate: doc.data['restat_last_sales_date']?.toDate() ?? null,
        meanPayment: doc.data['restat_mean_payment']?.toString() ?? '',
        meanPurchase: doc.data['restat_mean_purchase']?.toString() ?? '',
        meanReceipt: doc.data['restat_mean_receipt']?.toString() ?? '',
        meanSales: doc.data['restat_mean_sales']?.toString() ?? '',
        partyGuid: doc.data['restat_party_guid']?.toString() ?? '',
        totalPayables: doc.data['restat_total_payables']?.toString() ?? '',
        totalPayment: doc.data['restat_total_payment']?.toString() ?? '',
        totalSales: doc.data['restat_total_sales']?.toString() ?? '',
        totalPurchase: doc.data['restat_total_purchase']?.toString() ?? '',
        totalReceipt: doc.data['restat_total_receipt']?.toString() ?? '',
        totalReceivables: doc.data['restat_total_receivables']?.toString() ?? '',
        primaryGroupType:
            doc.data['restat_primary_group_type']?.toString() ?? '',
        restatCompanyCode: doc.data['restat_company_code']?.toString() ?? '',
        numPaymentVouchers:
            doc.data['restat_num_payment_vouchers']?.toString() ?? '',
        numPurchaseVouchers:
            doc.data['restat_num_purchase_vouchers']?.toString() ?? '',
        numReceiptVouchers:
            doc.data['restat_num_receipt_vouchers']?.toString() ?? '',
        numSalesVouchers:
            doc.data['restat_num_sales_vouchers']?.toString() ?? '',
      );
    }).toList();
  }
}
