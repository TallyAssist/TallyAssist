import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/voucher-item.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/ui/shared/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tassist/theme/theme.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/ui/widgets/detailcard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tassist/core/services/voucher-item-service.dart';
import 'package:intl/intl.dart';

var formatter = new DateFormat('dd-MM-yyyy') ?? null;


class VoucherView extends StatelessWidget {

  final String voucherId;

  VoucherView({this.voucherId});


  @override
  Widget build(BuildContext context) {

    
  final user = Provider.of<FirebaseUser>(context);

    Iterable<Voucher> voucherList = Provider.of<List<Voucher>>(context).where((item) => item.masterid == voucherId) ?? [];
    Voucher voucher = voucherList.elementAt(0) ?? [];
    
     final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();

    return MultiProvider(
          providers: [
            StreamProvider<List<VoucherItem>>.value(
              value: VoucherItemService(uid: user?.uid, voucherId: voucherId).voucherItemData,
            )
          ],
          child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            key: _drawerKey,
            drawer: tassistDrawer(context),
            appBar: headerNavOther(_drawerKey, context),
            body: Column(
              children: <Widget>[
                  Padding(
                    padding: spacer.all.xxs,
                    child: Text(voucher.partyname, style: Theme.of(context).textTheme.headline6,),
                  ),
                   Container(
                    height: 3.0,
                    color: TassistGray
                  ),
                  Padding(
                    padding: spacer.all.xxs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                            Container(
                        padding: spacer.all.xxs,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: TassistBgLightPurple,
                        ),
                        child: Text(voucher.primaryVoucherType),
                      ),
                      // SizedBox(width: 20),
                      Text(voucher.type),
                      _isInvoice(voucher),
                      ],
                    ),
                  ),
                  Padding(
                    padding: spacer.all.xxs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                              Text(voucher.amount.toString() ?? '', style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold
                              )) ,
                              Text('Amount')
                          ],
                        ),

                         Column(
                          children: <Widget>[
                              Text(formatter.format(voucher.date) ?? 'NA', style: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold
                              )) ,
                              Text('Due Date')
                          ],
                        )
                      
                      ],
                    ),
                  ),
                  Padding(
                    padding: spacer.all.xxs,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[ 
                      Text('Reference: ${voucher.reference}' ?? '')
                      ]
                      ),
                  ),
                  Container(
                    height: 3.0,
                    color: TassistGray
                  ),
                   VoucherItemView(),
                   Container(
                    height: 3.0,
                    color: TassistGray
                  ),
                  Text('Tax Summary'),
                  Container(
                    height: 20,
                  ),
                   Container(
                    height: 3.0,
                    color: TassistGray
                  ),
                  Text('Total Invoice: ${voucher.amount}', style: Theme.of(context).textTheme.bodyText2,)

              ],
            )
         

            )
        
      ),
    );
  }
}

class VoucherItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    List<VoucherItem> voucherItemList = Provider.of<List<VoucherItem>>(context) ?? [];

    return Column(
      children: <Widget>[
        Text('Item Details'),
        ListView.builder(
          shrinkWrap: true,
          itemCount: voucherItemList?.length,
          itemBuilder: (context, index){
            return VoucherItemTile(voucherItem: voucherItemList[index]);
          }
          )
      ],

      
    );
  }
}

class VoucherItemTile extends StatelessWidget {

   final VoucherItem voucherItem;

    VoucherItemTile({this.voucherItem});
  @override
  Widget build(BuildContext context) {

    return DetailCard(voucherItem.stockItemName, '${voucherItem.billedQty} Qty @ ${voucherItem.rate}/item', 'GST @ ${voucherItem.gstPercent}%: ${voucherItem.taxAmount}',  'Amount: ${voucherItem.amount}', 'Discount: ${voucherItem.discount}');
  }
}

_isInvoice(Voucher voucher) {
   if (voucher.isInvoice == '1') {
                return   Text('Invoice', style: TextStyle(
                  color: TassistBgPurple,
                  fontWeight: FontWeight.bold,
                ));
                      }
}



AppBar headerNavOther(GlobalKey<ScaffoldState> _drawerkey, BuildContext context) {
  bool enabled = true;

  return AppBar(
      leading: Padding(
        padding: EdgeInsets.only(left: 12),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (enabled) {

              Navigator.of(context).pushReplacementNamed('/ledgerview');
            }
          },
        ),
      ),
      elevation: 0.7,    
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
