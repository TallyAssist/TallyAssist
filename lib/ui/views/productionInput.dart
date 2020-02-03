import 'package:flutter/material.dart';
import 'package:tassist/core/models/production.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';

import 'package:tassist/ui/shared/bottomsheetcustom.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/shared/headernav.dart';
import 'package:tassist/core/services/database.dart';
import 'package:provider/provider.dart';
import 'package:tassist/ui/widgets/productionForm.dart';
import 'package:tassist/ui/widgets/productionList.dart';
import 'package:tassist/ui/widgets/sectionHeader.dart';





class ProductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _showProductionPanel() {
      showModalBottomSheetCustom(context: context, builder: (context) {
        return Container(
          padding: spacer.all.xs,
          child: ProductionForm(),
        );
      }
      );
    }

    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();


    return StreamProvider<List<Production>>.value (
          value: DatabaseService().productionData,
          child: Scaffold(
            key: _drawerKey,
        drawer: tassistDrawer(context),
        appBar: headerNav(_drawerKey),
        // bottomNavigationBar: bottomNav(),
        body: Column(
          children: <Widget>[
            SectionHeader('Daily Production Report'),
          
             ProductionList(),
             
          ],

        ),
        floatingActionButton: Padding(
          padding: spacer.all.xs,
          child: FloatingActionButton(
                        child: Icon(Icons.add),
                        backgroundColor: TassistPrimaryBackground,
                        onPressed: () => _showProductionPanel(),
                    ),
        ), 
        
        ),
          );
  }
}