import 'package:flutter/material.dart';

import 'dashboard.dart';
import 'menu.dart';

class NotificationScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    var onPressed2;
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 12),
              child: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MenuScreen(),
                    ),
                  );
                },
              ),
            ),
            title: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    const Text('ABC Pvt Ltd'),
                    const Text(
                     "GSTIN: 128238NDSA923",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            backgroundColor: Colors.black,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add_alarm),
                onPressed: onPressed2,
          )
        ],
      ),
     body: ListView.builder(itemBuilder: (
       BuildContext context, int index) {
         return Card(
           child: Padding(
             padding: const EdgeInsets.all(25.0),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Text('Note Title',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Note Text',
                 style: TextStyle(
                  fontSize: 14,
                 )
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Note Text',
                  style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey
                  ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Note Text',                 
                  style: TextStyle(
                  fontSize: 14,
                  ),
                 ),
               ),
              ] 
              ),
               Row(
                 children: <Widget>[
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Note Text',
                  style: TextStyle(
                  fontSize: 14,
                  ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Text('Note Text',
                  style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey
                  ),
                 ),
               ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Note Text',
                  style: TextStyle(
                  fontSize: 14,
                  ),
                 ),
              ),
             ]
               ),
             Row(
               children: <Widget>[

                 Container(
                   child: IconButton(
                     onPressed:() {
                       AlertDialog(
                         title: Text("Apka mail jaa raha hai.."),
                         );
                     },
                     icon: Icon(Icons.mail),
                     color: Colors.indigo,
                     alignment: Alignment.bottomRight,
                   ),
                 ),
                 IconButton(
                   onPressed:() {
                     AlertDialog(
                       title: Text("WhatsApp ho gaya!"),
                       );
                   },
                   icon: Icon(Icons.message),
                   color: Colors.greenAccent.shade400,
                   alignment: Alignment.bottomRight,

                 ),
               ],
             )
             ],
           ),
         )
         );

     },
      itemCount: 5,
     ),
    );
  }
}


    