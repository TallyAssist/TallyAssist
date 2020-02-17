import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tassist/ui/views/ledgerstock.dart';
import 'package:tassist/ui/views/ledgersummary.dart';
import 'package:tassist/ui/views/ledgervoucher.dart';


class LedgerView extends StatefulWidget {
  

  @override
  _LedgerViewState createState() => _LedgerViewState();
}

class _LedgerViewState extends State<LedgerView>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;
  

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 0, length: 3);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  
  
  @override
  Widget build(BuildContext context) {
  
   final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();
  
    return WillPopScope (
              onWillPop: () async => false,
          child: Scaffold(
        key: _drawerKey,
        appBar: headerNavOther(_drawerKey, _tabController),
        drawer: tassistDrawer(context),
        body: 
        TabBarView(
          controller: _tabController,
          children: <Widget>[
           LedgerSummary(),
           LedgerVoucher(),
           LedgerStock()
          ],
        ),
      ),
    );
  }
}


AppBar headerNavOther(GlobalKey<ScaffoldState> _drawerkey, TabController _tabController) {
  bool enabled = true;

  return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 12),
        child: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            if (enabled) {

              _drawerkey.currentState.openDrawer();
            }
          },
        ),
      ),
      elevation: 0.7,
      bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(text: 'Summary',),
            Tab(text: 'Vouchers'),
            Tab(
              text: 'Stock',
            ),
          ],
        ),
        
      title: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'TallyAssist',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const Text(
                'Beta',
                style: TextStyle(
                  color: TassistWhite,
                  fontSize: 12,
                  letterSpacing: 1.0,
                ),
              ),
          ],
        ),
        Spacer(),
        Text('Help?', style: TextStyle(fontSize: 14.0, letterSpacing: 1.0),),
        IconButton(
        icon: Icon(FontAwesomeIcons.whatsapp),
        onPressed: () => _launchURL()
            )
        // DropDownMonths(),
      ],
    ),
    backgroundColor: TassistMenuBg
  );
}


_launchURL() async {
  const url = 'https://api.whatsapp.com/send?phone=+917759091029';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
