import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MetricsWidget extends StatefulWidget {
  final String metricsWidgetTitle;
  final String metricsWidget;
  
  MetricsWidget({this.metricsWidgetTitle, this.metricsWidget});
  

  @override
  _MetricsWidgetState createState() => _MetricsWidgetState();
}


class _MetricsWidgetState extends State<MetricsWidget> {
 
  @override

  Widget build(BuildContext context) {
    
final snapshot = Provider.of<DocumentSnapshot>(context);

      var userDocument = snapshot.data;


    return Column(
      children: <Widget>[
              Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          widget.metricsWidgetTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                    ),
                    Text(
                      userDocument[widget.metricsWidget].toString(),
                      style: TextStyle(fontSize: 17.0),
                    ),
                    ],
                    );
  }
}