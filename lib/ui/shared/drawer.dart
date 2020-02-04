import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/views/accountsreceivables.dart';
import 'package:tassist/ui/views/dashboard.dart';
import 'package:tassist/ui/views/gstreportscreen.dart';
import 'package:tassist/ui/views/khatascreen.dart';
import 'package:tassist/ui/views/ledgerscreen.dart';
import 'package:tassist/ui/views/notifications.dart';
import 'package:tassist/ui/views/productionInput.dart';
import 'package:tassist/ui/views/pruchaseorderreport.dart';
import 'package:tassist/ui/views/salesorderreport.dart';
import 'package:tassist/ui/views/stockscreen.dart';

 final AuthService _auth = AuthService();

Drawer tassistDrawer(BuildContext context) {
  
  return Drawer(
      child: ListView(
    children: <Widget>[
      DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: Icon(
                Icons.person_outline,
                color: TassistInfoGrey,
                size: 50.0,
              ),
              radius: 30.0,
              backgroundColor: TassistWhite,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'John Doe',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: TassistWhite),
            ),
            Text('Company: ABC Pvt. Ltd.', 
             style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: TassistWhite),
            )

          ],
        ),
        decoration: BoxDecoration(
          color: TassistMenuBg,
          shape: BoxShape.rectangle,
        ),
      ),
      Padding(
        padding: spacer.all.xs,
        child: Text('Reports', style: Theme.of(context).textTheme.body1),
      ),
      // DrawerItem(
      //   icon: Icons.mail_outline,
      //   title: 'Notifications',
      //   ontap: NotificationScreen(),
      //   color: TassistPrimaryBackground,
      // ),
      DrawerItem(
        icon: Icons.dashboard,
        title: 'Dashboard',
        ontap: DashboardScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: Icons.card_membership,
        title: 'Sales',
        ontap: SalesOrderReportScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: Icons.inbox,
        title: 'Purchases',
        ontap: PurchaseOrderReportScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: Icons.computer,
        title: 'GST Report',
        ontap: GstReportScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: FontAwesomeIcons.warehouse,
        title: 'Stock',
        ontap: StockScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: FontAwesomeIcons.listAlt,
        title: 'Ledgers',
        ontap: LedgerScreen(),
        color: TassistPrimaryBackground,
      ),
       DrawerItem(
        icon: Icons.call_received,
        title: 'Accounts Receivables',
        ontap: AccountsReceivableScreen(),
        color: TassistPrimaryBackground,
      ),
       Padding(
        padding: spacer.all.xs,
        child: Text('Specials', style: Theme.of(context).textTheme.body1),
      ),
      DrawerItem(
        icon: Icons.lock,
        title: 'Apka Secret Khata',
        ontap: KhataScreen(),
        color: TassistInfoGrey,
      ),
      DrawerItem(
        icon: Icons.build,
        title: 'Production',
        ontap: ProductionScreen(),
        color: TassistPrimaryBackground,
      ),
      SizedBox(height: 20.0,),
       Padding(
            padding: spacer.y.xxs,
            child: InkWell(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: spacer.x.xs,
                    child: Icon(
                      Icons.lock_open,
                      color: TassistPrimaryBackground,
                    ),
                  ),
                  Text(
                    'Sign Out',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .title,
                  ),
                ],
              ),
              onTap: () async {
                await _auth.signOut();
              },
            ),
          ),
    ],
  ));
}

class DrawerItem extends StatefulWidget {
  final IconData icon;
  final String title;
  final Widget ontap;
  final Color color;

  DrawerItem({this.icon, this.title, this.ontap, this.color});

  @override
  _DrawerItemState createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: TassistSuccess,
      child: Padding(
        padding: spacer.y.xxs,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: spacer.x.xs,
              child: Icon(
                widget.icon,
                color: widget.color,
              ),
            ),
            Text(
              widget.title,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.title.copyWith(
                color: widget.color
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => widget.ontap,
        ));
      },
    );
  }
}
