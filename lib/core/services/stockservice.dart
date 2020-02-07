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

  List<StockItem> _stockItemData(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return StockItem(
        name: doc.data['name'] ?? '',
        masterId: doc.data['master_id'] ?? '',
        closingBalance: doc.data['closingbalance'].toString() ?? '',
        closingValue: doc.data['closingvalue'].toString() ?? '',
        baseUnit: doc.data['baseunits'] ?? '',
        closingRate: doc.data['closingrate'].toString() ?? '',
        standardCost: doc.data['standardcost'].toString() ?? '',
        standardPrice: doc.data['standardprice'].toString() ?? '',
      );
    }).toList();
  }
}
