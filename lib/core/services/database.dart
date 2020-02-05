import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/production.dart';
import 'package:tassist/core/models/khata.dart';
import 'package:tassist/core/models/salesvoucher.dart';



class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // create metric collection on signup
  final CollectionReference metricCollection =
      Firestore.instance.collection('metrics');

  Future createMetricsRecord() async {
    return await metricCollection.document(uid).setData({
      'total_sales': 0,
    });
  }

    Stream<QuerySnapshot> get sales => metricCollection.snapshots();

  final CollectionReference productionCollection = 
    Firestore.instance.collection('company').document('PTDQMfuftCgJJiA6UwZOExfawV23').collection('production');

  Future createProductionRecord(DateTime date, String product, String production) async {
    return await productionCollection.document(this.uid).setData({
      'Date': date,
      'Product': product,
      'Production': production,
    });
  }


// defining a list of production data items 
  List<Production> _productionListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
          return Production(
            date: doc.data['Date'].toDate() ?? '',
            product: doc.data['Product'] ?? '',
            production: doc.data['Production'] ?? 0,
          );
        }).toList();
      }
    
// Creating a stream of production data items so that we can listen on them
    Stream<List<Production>> get productionData {
      return productionCollection
      .orderBy('Date', descending: true)
      .snapshots()
      .map(_productionListfromSnapshot);
    }

//Connectiong to Collection Products
final CollectionReference productCollection = 
    Firestore.instance.collection('products');


// //Connectiong to Collection Products
final CollectionReference khataCollection = 
    Firestore.instance.collection('khata');


// CTS

Future createKhataRecord(DateTime date, String partyname, String amount, String trantype) async {
    return await khataCollection.document('PTDQMfuftCgJJiA6UwZOExfawV23').collection('transations').document().setData({
      'date': date,
      'trantype': trantype,
      'partyname': partyname,
      'amount': amount,
    });
  }


Future deleteKhata(String id) async {
  await khataCollection.document(this.uid).collection('transations').document(id).delete();
}

// defining a list of production data items 
  List<Khata> _khatarecordfromSnapshots (QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
          return Khata(
            date: doc.data['date'].toDate() ?? '',
            partyname: doc.data['partyname'] ?? '',
            amount: doc.data['amount'] ?? '',
            trantype: doc.data['trantype'] ?? '',
          );
        }).toList();
      }
    
// Creating a stream of production data items so that we can listen on them
    Stream<List<Khata>> get khataData {
      return khataCollection.document(this.uid)
      .collection('transations')
      .orderBy('date', descending: true)
      .snapshots()
      .map(_khatarecordfromSnapshots);
    }
  }



class SalesVoucherService {

    final String uid;
    SalesVoucherService({this.uid});


  final CollectionReference companyCollection = 
Firestore.instance.collection('company');

Stream<List<SalesVoucher>> get salesVoucherData {
      return companyCollection.document('PTDQMfuftCgJJiA6UwZOExfawV23')
      .collection('voucher')
      .where('primary_voucher_type_name', isEqualTo: 'Sales')
      .orderBy('amount', descending: false)
      .snapshots()
      .map(_salesvouchersfromSnapshots);
    }

 List<SalesVoucher> _salesvouchersfromSnapshots (QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return SalesVoucher(
        date: doc.data['date'] ?? '',
        partyname: doc.data['party_ledger_name'] ?? '',
        amount: doc.data['amount'].toInt() ?? 0,
        masterid: doc.data['master_id'] ?? '',
        iscancelled: doc.data['is_cancelled'] ?? '',
                  );
           }).toList();
        }
  }