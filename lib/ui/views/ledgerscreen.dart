import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/ledger.dart';
import 'package:tassist/core/services/ledgerservice.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/ui/widgets/partyscreen/ledgeritemlist.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';


class LedgerScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

  final user = Provider.of<FirebaseUser>(context);
  final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return StreamProvider<List<LedgerItem>>.value (
          value: LedgerItemService(uid: user.uid).ledgerItemData,
          child: WillPopScope (
              onWillPop: () async => false,
                      child: Scaffold(
            key: _drawerKey,
        drawer: tassistDrawer(context),
        appBar: headerNav(_drawerKey),
        body: ListView(
            children: <Widget>[
            SectionHeader('Ledgers'),
            LedgerItemList()


  ],
)



        
      ),
          ),
    );
  }
}


