import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/models/production.dart';


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
    Firestore.instance.collection('production');

  Future createProductionRecord(String date, String product, String production) async {
    return await productionCollection.document(uid).setData({
      'Date': date,
      'Product': product,
      'Production': production,
    });
  }


// defining a list of production data items 
  List<Production> _productionListfromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
          return Production(
            date: doc.data['Date'] ?? '',
            product: doc.data['Product'] ?? '',
            production: doc.data['Production'] ?? 0,
          );
        }).toList();
      }
    
// Creating a stream of production data items so that we can listen on them
    Stream<List<Production>> get productionData {
      return productionCollection.snapshots()
      .map(_productionListfromSnapshot);
    }

//Connectiong to Collection Products
final CollectionReference productCollection = 
    Firestore.instance.collection('products');



    }
    
   