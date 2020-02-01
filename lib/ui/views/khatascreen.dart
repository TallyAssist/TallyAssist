import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/shared/bottomnav.dart';
import 'package:tassist/ui/shared/bottomsheetcustom.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/core/services/database.dart';
import 'package:provider/provider.dart';
import  'package:tassist/ui/widgets/khataScreen/khataform.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';
import 'package:tassist/core/models/khata.dart';
import 'package:tassist/ui/widgets/khataScreen/khatalist.dart';




class KhataScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

   final user = Provider.of<FirebaseUser>(context);

    void _showKhataPanel() {
      showModalBottomSheetCustom(context: context, builder: (context) {
        return Container(
          padding: spacer.all.xs,
          child: KhataForm(),
        );
      }
      );
    }
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();


    return StreamProvider<List<Khata>>.value (
          value: DatabaseService(uid: user.uid).khataData,
          child: Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
        appBar: headerNav(_drawerKey),
        bottomNavigationBar: bottomNav(),
        body: Column(
          children: <Widget>[
            SectionHeader('Your Secret Khata'),
            Container(
              child: Text('  Not syncing with Tally :) Swipe to delete.'),
              color: TassistWarningShadow,
              width: MediaQuery.of(context).size.width,
              ),
            KhataList(),
            
             
          ],

        ),
        floatingActionButton: Padding(
              padding: spacer.x.xs,
              child: FloatingActionButton(
                  child: Icon(Icons.add),
                  backgroundColor: TassistPrimaryBackground,
                  onPressed: () => _showKhataPanel(),
              ),
            ),  
        
        ),
          );
  }
}