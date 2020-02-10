import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/stockitem.dart';
import 'package:tassist/core/services/stockservice.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';
import 'package:tassist/ui/widgets/stockscreen/stocklist.dart';

class StockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return StreamProvider<List<StockItem>>.value(
      value: StockItemService(uid: user.uid).stockItemsData,
      child: WillPopScope (
              onWillPop: () async => false,
              child: Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
            appBar: headerNav(_drawerKey),
            body: Container(
              child: ListView(
                children: <Widget>[SectionHeader('Stock Items'), StockItemList()],
              ),
            )),
      ),
    );
  }
}
