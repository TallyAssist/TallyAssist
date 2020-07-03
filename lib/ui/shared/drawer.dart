import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';
import 'package:tassist/ui/views/accountspayablescreen.dart';
import 'package:tassist/ui/views/accountsreceivables.dart';
// import 'package:tassist/ui/views/crm.dart';
import 'package:tassist/ui/views/home.dart';
import 'package:tassist/ui/views/ledgerinput.dart';
import 'package:tassist/ui/views/khatascreen.dart';
import 'package:tassist/ui/views/ledgerscreen.dart';
import 'package:tassist/ui/views/settingsscreen.dart';
// import 'package:tassist/ui/views/productionInput.dart';
// import 'package:tassist/ui/views/pruchaseorderreport.dart';
// import 'package:tassist/ui/views/salesorderreport.dart';
import 'package:tassist/ui/views/stockscreen.dart';
import 'package:tassist/ui/views/vouchers.dart';
// import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

final AuthService _auth = AuthService();

Drawer tassistDrawer(BuildContext context) {
  final user = Provider.of<FirebaseUser>(context);

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
                  size: 40.0,
                ),
                radius: 25.0,
                backgroundColor: TassistWhite,
              ),
            SizedBox(width: 70,),
            
            
           
            FittedBox(
              child: Text(
                user?.email ?? 'No email',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: TassistWhite,
                      fontSize: 14.0,
                    ),
              ),
            ),

                //  RaisedButton( 
                //    color: TassistWhite,
                //    child:
                //    Row(children: <Widget>[
                //   Icon(FontAwesomeIcons.laptop),
                //   SizedBox(width: 20),
                //   Text('Get Tally Connector')

                //    ]),
                // onPressed: () => _launchURL(),)
          ],
        ),
        decoration: BoxDecoration(
          color: TassistMenuBg,
          shape: BoxShape.rectangle,
        ),
      ),
      Padding(
        padding: spacer.all.xxs,
        child: Text('Reports', style: Theme.of(context).textTheme.bodyText1),
      ),
      DrawerItem(
        icon: Icons.dashboard,
        title: 'Home',
        ontap: HomeDashboardScreen(),
        color: TassistPrimaryBackground,
      ),
      
      DrawerItem(
        icon: FontAwesomeIcons.listAlt,
        title: 'Ledgers / Parties',
        ontap: LedgerScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: Icons.call_received,
        title: 'Accounts Receivables',
        ontap: AccountsReceivableScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: Icons.call_made,
        title: 'Accounts Payables',
        ontap: AccountsPayableScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: FontAwesomeIcons.warehouse,
        title: 'Stock',
        ontap: StockScreen(),
        color: TassistPrimaryBackground,
      ),
      DrawerItem(
        icon: FontAwesomeIcons.fileInvoice,
        title: 'Vouchers',
        ontap: VouchersHome(),
        color: TassistPrimaryBackground,
      ),
       DrawerItem(
        icon: Icons.receipt,
        title: 'Make New Invoice',
        ontap: LedgerInputScreen(),
        color: TassistPrimary,
      ),
      
      Padding(
        padding: spacer.all.xxs,
        child: Text('Specials', style: Theme.of(context).textTheme.bodyText1),
      ),
      DrawerItem(
        icon: Icons.lock,
        title: 'Bahi Khata',
        ontap: KhataScreen(),
        color: TassistMainText,
      ),
      DrawerItem(
        icon: Icons.settings,
        title: 'Settings',
        ontap: SettingsScreen(),
        color: TassistMainText,
      ),
      SizedBox(
        height: 20.0,
      ),
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
                style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 16 ),
              ),
            ],
          ),
          onTap: () async {
            await _auth.signOut().then((_) {
              // Navigator.popUntil(context, );
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new MyApp()),
                  ModalRoute.withName('/'));
            });
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
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: widget.color, fontSize: 16),
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


_launchURL() async {
  const url = '';
  // if (await canLaunch(url)) {
  //   await launch(url);
  // } else {
    throw 'Could not launch $url';
  // }
}
