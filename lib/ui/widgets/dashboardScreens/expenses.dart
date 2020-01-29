import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/database.dart';



class ExpenseDashboardWidget extends StatefulWidget {


  @override
  _ExpenseDashboardWidgetState createState() => _ExpenseDashboardWidgetState();
}

class _ExpenseDashboardWidgetState extends State<ExpenseDashboardWidget> {


  @override
  Widget build(BuildContext context) {

      final user = Provider.of<FirebaseUser>(context);

  return StreamProvider<DocumentSnapshot>.value (
          value: DatabaseService().metricCollection.document(user.uid).snapshots(),
          child: Container(
      child: Column(
        children: <Widget>[
          Container(
            child: ExpenseDashboardWidgetTitleRow(),
          ),
          const SizedBox(
            height: 20,
          ),
          ExpenseDashboardWidgetContentRow(),
        ],
      ),
    ),
  );
  }
}

class ExpenseDashboardWidgetContentRow extends StatefulWidget {

  @override
  _ExpenseDashboardWidgetContentRowState createState() => _ExpenseDashboardWidgetContentRowState();
}

class _ExpenseDashboardWidgetContentRowState extends State<ExpenseDashboardWidgetContentRow> {
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
                    Text(
                      userDocument['total_expenses'].toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Text('Total Expenses'),
              ],
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.red,
                    ),
                    Text(
                      '20k',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
                Text('Unpaid expenses'),
              ],
            ),
          ),
        ],
      );
  }
}

class ExpenseDashboardWidgetTitleRow extends StatelessWidget {
  const ExpenseDashboardWidgetTitleRow({
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
                'Expenses',
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
