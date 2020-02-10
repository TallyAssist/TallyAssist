
import 'package:flutter/material.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/theme/theme.dart';

// class ItemList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//             itemCount: 5,
//             itemBuilder: (BuildContext context, int index) {
//               return Card(
//                 child: Row(
//                   children: <Widget>[
//                     SingleItem('Customer 1', 'Rs. 123,21,33')
//                   ],

//                 ), 
//               );

//             }          
//             );
//   }
// }

class SingleItem extends StatelessWidget {

  final String name;
  final String value;

SingleItem(this.name, this.value);

 @override
  Widget build(BuildContext context) {
    return FittedBox(
          child: Row(
        children: <Widget>[
          SizedBox(width: 5,),
          Text(name,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
            fontSize: 14
          ),
          ),
          SizedBox(width: 5,),
          Text(value),
          SizedBox(width: 5,),
          Container(
            padding: spacer.all.xxs,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TassistGray
            )
            ),
              Container(
            padding: spacer.all.xxs,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TassistGray
            )
            ),
              Container(
            padding: spacer.all.xxs,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TassistGray
            )
            ),
              Container(
            padding: spacer.all.xxs,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TassistSuccess
            )
            ),
              Container(
            padding: spacer.all.xxs,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TassistSuccessLight
            )
            ),
              Container(
            padding: spacer.all.xxs,
            margin: EdgeInsets.all(1),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: TassistGray
            )
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.call),
            )
        ],
          
      ),
    );


  }
}  

