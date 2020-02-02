
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tassist/theme/colors.dart';


class PurchaseDashboardWidget extends StatefulWidget {


  @override
  _PurchaseDashboardWidgetState createState() => _PurchaseDashboardWidgetState();
}

class _PurchaseDashboardWidgetState extends State<PurchaseDashboardWidget> {
  @override
  Widget build(BuildContext context) {

   return Container(
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
                    color: TassistSuccess,
                  ),
                  Text(userDocument['total_purchases'].toString(),
                    style: Theme.of(context).textTheme.body2.copyWith(
                        color: TassistSuccess,
                        fontSize: 24,
                      ),
                  ),
                ],
              ),
              Text('Total Purchases'),
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
                    color: TassistWarning,
                  ),
                  Text(
                    userDocument['open_purchase_orders'].toString(),
                    style: Theme.of(context).textTheme.body2.copyWith(
                        color: TassistWarning,
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
                color: TassistPrimaryBackground,
              ),
              Icon(
                Icons.bookmark,
                color: TassistPrimaryBackground,
              ),
              Icon(
                Icons.share,
                color: TassistPrimaryBackground,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
