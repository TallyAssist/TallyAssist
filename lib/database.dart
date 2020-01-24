import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // create metric collection on signup
  final CollectionReference metricCollection =
      Firestore.instance.collection('metrics');

  Future createMetricsRecord() async {
    return metricCollection.document(uid).setData({
      'total_sales': 0,
    });
  }
}
