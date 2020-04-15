import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/texts.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/widgets/productcard.dart';

class LedgerInputScreen extends StatefulWidget {
  

  @override
  _LedgerInputScreenState createState() => _LedgerInputScreenState();
}

class _LedgerInputScreenState extends State<LedgerInputScreen> {
      final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

      bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {

    
    return WillPopScope (
              onWillPop: () async => false,
          child: Scaffold(
        key: _drawerKey,
        drawer: tassistDrawer(context),
        appBar: headerNav(_drawerKey),
        // bottomNavigationBar: bottomNav(),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: spacer.all.xxs,
              child: TextFormField(
                style: secondaryListDisc,
                decoration: InputDecoration(
                  icon: Icon(Icons.person_add, color: TassistPrimary,),
                  hintText: 'Select customer',
                  hintStyle: secondaryHint,
                  labelText: 'Customer name',
                  labelStyle: secondaryListTitle
                ),
              ),
            ),
            Padding(
              padding: spacer.all.xxs,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                    Text('GST: ABCDEFGHIJKLM', style: secondaryListTitle2,),
                    ],
                  ),
                 Column(
                   children: <Widget>[
                     Row(
                        children: <Widget>[
                          Icon(Icons.phone, color: TassistPrimary),
                          Text(' 7759091029  ', style: secondaryListTitle2,)
                          
                        ],
                     )
                

                   ],
                 )

                 
            
                ],
              ),
            ),

            Container(
              color: TassistInfoGrey,
              height: 2,
            ),
            Padding(
              padding: spacer.left.xxs,
              child: 
              Row(children: <Widget>[
                Flexible(
                  flex: 3,
                                  child: TextFormField(
                  style: secondaryListDisc,
                  decoration: InputDecoration(
                    icon: Icon(Icons.playlist_add, color: TassistPrimary,),
                    hintText: 'Add product',
                    hintStyle: secondaryHint,
                    labelText: 'Product to be billed',
                    labelStyle: secondaryListTitle
                  ),
              ),
                ),
              SizedBox(width: 20),
               Flexible(
                 flex: 1,
                                child: 
                                new TextField(
        style: secondaryListDisc,
          decoration: InputDecoration(
               
                 labelText: 'GST %',
                  labelStyle: secondaryListDisc
          )
      ),
               ),  


              ],)
              
            ), 
            
            Padding(
              padding: spacer.all.xxs,
              child: new Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: <Widget>[
    new Flexible(
      child: new TextField(
          style: secondaryListDisc,
          decoration: InputDecoration(
                icon: Icon(Icons.attach_money, color: TassistPrimary),
                contentPadding: EdgeInsets.all(10),
                 labelText: 'Price',
                  labelStyle: secondaryListDisc
          )
      ),
    ),
    SizedBox(width: 20.0,),
    new Flexible(
      child: new TextField(
        style: secondaryListDisc,
          decoration: InputDecoration(
                            icon: Icon(Icons.shopping_cart, color: TassistPrimary),
                contentPadding: EdgeInsets.all(10),
                 labelText: 'Qty',
                  labelStyle: secondaryListDisc
          )
      ),
    ),
    SizedBox(width: 20.0,),
    new Flexible(
      child: RaisedButton(
          onPressed: () {},
        child: Icon(Icons.add, color: TassistWhite,),
        color: TassistPrimaryDarkButtonShadow,
        textColor: Colors.white,
        elevation: 5,),
    ),
  ],
),
            ),
              
            ProductCard(
        'Product 1', 'HSN Code: ABCDEF', 
        '100 Qty @ 10/item',
        'GST @ 5%: 50',
        'Amount: 1000',
        'Discount: 10'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
          children: <Widget>[
        
        Column(children: <Widget>[
          Row(children: <Widget>[
          Checkbox(value: checkboxValue, onChanged: (bool value) {
          setState(() {
            print(value);
            checkboxValue = value;
          });
        }, 
        activeColor: TassistPrimary,
        ),
        Text('Include payment link', style: secondaryListDisc,)
        ],)


        ],),

        Column(
          children: <Widget>[
            Text('Total: 1000', style: secondaryListTitle),
            Text('Tax: 50', style: secondaryListTitle2,)
          ],

  
        )
        ],),
         

          ]
        ),
        bottomNavigationBar: Row(
          
          children: <Widget>[
          
          Flexible(
          child: ButtonTheme(
            minWidth: MediaQuery.of(context).size.width / 2,
                      child: RaisedButton(
              onPressed: () {},
            child: Text('Draft!', style: TextStyle(fontSize: 20)),
            color: TassistInfoGrey,
            textColor: Colors.white,
            elevation: 5,),
          ),
        )    ,    
        
          Flexible(
          
          child: ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width / 2,


                      child: RaisedButton(

              onPressed: () {},
            child: Text('Send!', style: TextStyle(fontSize: 20)),
            color: TassistPrimary,
            textColor: Colors.white,
            elevation: 5,),
          ),
        )        
        ,


        ],)
        
        
       
          )
    );
  }
}
