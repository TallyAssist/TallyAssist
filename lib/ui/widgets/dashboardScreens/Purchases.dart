
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/core/services/database.dart';


class PurchaseDashboardWidget extends StatefulWidget {


  @override
  _PurchaseDashboardWidgetState createState() => _PurchaseDashboardWidgetState();
}

class _PurchaseDashboardWidgetState extends State<PurchaseDashboardWidget> {
  @override
  Widget build(BuildContext context) {

   final user = Provider.of<FirebaseUser>(context);
    

    return StreamProvider<DocumentSnapshot>.value (
          value: DatabaseService().metricCollection.document(user.uid).snapshots(),
          child: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: PurchaseDashboardWidgetTitleRow(),
            ),
            const SizedBox(
              height: 20,
            ),
            PurchaseDashboardWidgetContentRow(),
          ],
        ),
      ),
    );
  }
}

class PurchaseDashboardWidgetContentRow extends StatelessWidget {
  


  @override
  Widget build(BuildContext context) {

    final snapshot = Provider.of<DocumentSnapshot>(context);

    var userDocument = snapshot.data; 

        
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.green,
                  ),
                  Text(userDocument['total_purchases'].toString(),
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Revenue'),
            ],
          ),
        ),
        Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.arrow_drop_up,
                    color: Colors.red,
                  ),
                  Text(
                    '24',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Open orders'),
            ],
          ),
        ),
      ],
    );
  }
}

class PurchaseDashboardWidgetTitleRow extends StatelessWidget {
  const PurchaseDashboardWidgetTitleRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Text(
                'Purchase',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Icon(
                Icons.info_outline,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.bookmark,
                color: Colors.purple[800],
              ),
              Icon(
                Icons.share,
                color: Colors.purple[800],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
