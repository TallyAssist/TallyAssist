import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/core/services/timeperiod_filter_service.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/texts.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:tassist/ui/views/voucher/paymentvouchers.dart';
import 'package:tassist/ui/views/voucher/purchasevouchers.dart';
import 'package:tassist/ui/views/voucher/receiptvouchers.dart';
import 'package:tassist/ui/views/voucher/salesvouchers.dart';
import 'package:tassist/ui/widgets/myboxdecoration.dart';
import 'package:url_launcher/url_launcher.dart';

class VouchersHome extends StatefulWidget {
  @override
  _VouchersHomeState createState() => _VouchersHomeState();
}

class _VouchersHomeState extends State<VouchersHome>
    // with SingleTickerProviderStateMixin 
    {
  // TabController _tabController;
  // bool showFab = true;

  String timePeriod = "Tomorrow";

  // @override
  // void initState() {
  //   super.initState();

  //   _tabController = TabController(vsync: this, initialIndex: 0, length: 4);
  //   _tabController.addListener(() {
  //     if (_tabController.index == 0) {
  //       showFab = true;
  //     } else {
  //       showFab = false;
  //     }
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultTabController(
        length: 4,
              child: Scaffold(
          key: _drawerKey,
          appBar: headerNavOther(_drawerKey),
          // , _tabController),
          drawer: tassistDrawer(context),
          body: SizedBox(
            // height: MediaQuery.of(context).size.height / 1.1,
            child: Column(
              children: <Widget>[
                Container(
                  decoration: myBoxDecorationBottomBorder(),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(4.0, 1.0, 10.0, 1.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Select timeperiod",
                          style: secondaryListTitle2,
                        ),
                        PopupMenuButton<String>(
                          icon: Icon(Icons.av_timer),
                          onSelected: (value) {
                            setState(() {
                              timePeriod = value;
                            });
                          },
                          itemBuilder: (BuildContext context) {
                            return timePeriodList.map(
                              (String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(
                                    choice,
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontSize: 14.0),
                                  ),
                                );
                              },
                            ).toList();
                          },
                        ),
                      ],
                    ),
                  ),
                  // color: Colors.blueGrey[100],
                  // width: MediaQuery.of(context).size.width,
                  height: 35,
                ),
                Expanded(
                  child: TabBarView(
                    // controller: _tabController,
                    children: <Widget>[
                      SalesVoucherScreen(timePeriod: timePeriod),
                      PurchaseVoucherScreen(timePeriod: timePeriod),
                      ReceiptVoucherScreen(timePeriod: timePeriod),
                      PaymentVoucherScreen(timePeriod: timePeriod),
                    ],
                  ),
                ),
              ], // child:
            ),
          ),
        ),
      ),
    );
  }
}

AppBar headerNavOther(
    GlobalKey<ScaffoldState> _drawerkey)
    // , TabController _tabController) 
    {
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
        // controller: _tabController,
        indicatorColor: Colors.white,
        tabs: <Widget>[
          Tab(
            text: 'Sales',
          ),
          Tab(text: 'Purchase'),
          Tab(
            text: 'Receipt',
          ),
          Tab(
            text: 'Payment',
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
          Text(
            'Help?',
            style: TextStyle(fontSize: 14.0, letterSpacing: 1.0),
          ),
          IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp),
              onPressed: () => _launchURL())
          // DropDownMonths(),
        ],
      ),
      backgroundColor: TassistMenuBg);
}

_launchURL() async {
  const url = 'https://api.whatsapp.com/send?phone=+917759091029';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
