import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/theme/colors.dart';


class SalesDashboardWidget extends StatefulWidget {



  @override
  _SalesDashboardWidgetState createState() => _SalesDashboardWidgetState();
}

class _SalesDashboardWidgetState extends State<SalesDashboardWidget> {
  @override
  Widget build(BuildContext context) {


    return Container(
        child: Column(
          children: <Widget>[
            Container(
              child: SalesDashboardWidgetTitleRow(),
            ),
            const SizedBox(
              height: 20,
            ),
            SalesDashboardWidgetContentRow(),
          ],
        ),
    );
  }
}

class SalesDashboardWidgetContentRow extends StatefulWidget {
 

  @override
  _SalesDashboardWidgetContentRowState createState() =>
      _SalesDashboardWidgetContentRowState();
}

class _SalesDashboardWidgetContentRowState
    extends State<SalesDashboardWidgetContentRow> {
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
                  Text(userDocument['total_sales'].toString() ?? '',
                  style: Theme.of(context).textTheme.body2.copyWith(
                    color: TassistSuccess,
                    fontSize: 24
                  ),
                  )
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
                    Icons.arrow_drop_down,
                    color: Colors.red,
                  ),
                  Text(
                  userDocument['total_sales_quantity'].toString() ?? '',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
              Text('Quantity'),
            ],
          ),
        ),
        // SimpleTimeSeriesChart.withSampleData(),
      ],
    );
  }
}

class SalesDashboardWidgetTitleRow extends StatelessWidget {
  const SalesDashboardWidgetTitleRow({
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
                'Sales',
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

