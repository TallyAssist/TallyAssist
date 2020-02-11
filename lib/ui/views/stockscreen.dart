import 'package:flutter/material.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';
import 'package:tassist/ui/widgets/stockscreen/stocklist.dart';

class StockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<FirebaseUser>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    // print('user obejct-----');
    // print(user);
    // print(StockItemService(uid: user.uid).stockItemsData);
    // print('s-----------;');
    // print('[+][+]This screen is being displayed.............');

    // StockItemService(uid: user.uid).stockItemsData.listen((event) {
    //   print('data via stream');
    //   print('value ');
    //   print(event);
    // });


    return Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
            appBar: headerNav(_drawerKey, context),
            body: Container(
      child: ListView(
        children: <Widget>[SectionHeader('Stock Items'), StockItemList()],
      ),
            ),
    );
  }
}
