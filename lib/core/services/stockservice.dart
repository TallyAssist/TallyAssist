import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/stockitem.dart';

class StockItemService {
  final String uid;
  StockItemService({this.uid});

  final CollectionReference companyCollection =
      Firestore.instance.collection('company');

  Stream<List<StockItem>> get stockItemsData {
    return companyCollection
        .document(this.uid)
        .collection('stockitem')
        .orderBy('closingvalue', descending: false)
        .snapshots()
        .map(_stockItemData);
  }

  Future saveStockItem({
    masterId,
    name,
    standardCost,
    standardPrice,
    baseUnits,
    closingBalance,
    minimumStock,
    reorderValue,
  }) async {
    return await companyCollection
        .document(this.uid)
        .collection('stockitem')
        .document(masterId)
        .setData({
      'name': name,
      'masterid': masterId,
      'standardcost': standardCost,
      'standardprice': standardPrice,
      'baseunits': baseUnits,
      'closingbalance': closingBalance,
      'minimumstock': minimumStock,
      'reordervalue': reorderValue,
    });
  }

  List<StockItem> _stockItemData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return StockItem(
        name: doc.data['name'] ?? '',
        masterId: doc.data['masterid'] ?? '',
        closingBalance: doc.data['closingbalance']?.toString() ?? '',
        closingValue: doc.data['closingvalue'] != ''
            ? (doc.data['closingvalue']?.toDouble() ?? 0)
            : 0,
        baseUnit: doc.data['baseunits']?.toString() ?? '',
        closingRate: doc.data['closingrate']?.toString() ?? '',
        standardCost: doc.data['standardcost']?.toString() ?? '',
        standardPrice: doc.data['standardprice']?.toString() ?? '',
      );
    }).toList();
  }
}
