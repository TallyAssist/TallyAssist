import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/paymentvoucher.dart';
import 'package:tassist/core/models/receiptvoucher.dart';
import 'package:tassist/core/models/salesvoucher.dart';
import 'package:tassist/core/models/stockitem.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/core/services/paymentvoucherservice.dart';
import 'package:tassist/core/services/purchasevoucherservice.dart';
import 'package:tassist/core/services/receiptvoucherservice.dart';
import 'package:tassist/core/services/stockservice.dart';
import 'package:tassist/ui/root_page.dart';
import 'package:tassist/theme/texts.dart';

import 'core/models/ledger.dart';
import 'core/models/purchasevoucher.dart';
import 'core/services/ledgerservice.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = "TallyAssist";

    return MultiProvider(providers: [
      StreamProvider<FirebaseUser>.value(
        value: AuthService().user,
      ),
    ], child: TopWidget(title: _title));
  }
}

class TopWidget extends StatelessWidget {
  const TopWidget({
    Key key,
    @required String title,
  })  : _title = title,
        super(key: key);

  final String _title;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return MultiProvider(
      providers: [
        StreamProvider<List<LedgerItem>>.value(
          initialData: List<LedgerItem>(),
          value: LedgerItemService(uid: user?.uid).accountsReceivableData,
        ),
        StreamProvider<List<LedgerItem>>.value(
            value: LedgerItemService(uid: user?.uid).ledgerItemData),
        StreamProvider<List<StockItem>>.value(
            value: StockItemService(uid: user?.uid).stockItemsData),
        StreamProvider<List<LedgerItem>>.value(
            value: LedgerItemService(uid: user?.uid).accountsPayablesData),
        StreamProvider<List<LedgerItem>>.value(
            value: LedgerItemService(uid: user?.uid).inactiveCustomerData),
        StreamProvider<List<SalesVoucher>>.value(
            value: SalesVoucherService(uid: user?.uid).salesVoucherData),
        StreamProvider<List<PurchaseVoucher>>.value(
            value: PurchaseVoucherService(uid: user?.uid).purchaseVoucherData),
        StreamProvider<List<PaymentVoucher>>.value(
            value: PaymentVoucherService(uid: user?.uid).paymentVoucherData),
        StreamProvider<List<ReceiptVoucher>>.value(
            value: ReceiptVoucherService(uid: user?.uid).receiptVoucherData),
        StreamProvider<DocumentSnapshot>.value(
            value: DatabaseService()
                .companyCollection
                .document(user?.uid)
                .snapshots()),
      ],
      child: MaterialApp(
        title: _title,
        // home: HomeScreen(),
        home: RootPage(),
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            textTheme: TextTheme(headline6: primaryAppBarTitle),
          ),
          textTheme: TextTheme(
              headline6: secondaryListTitle,
              subtitle1: secondaryCategoryDesc,
              bodyText1: secondaryListDisc,
              bodyText2: secondaryListTitle2),
        ),
      ),
    );
  }
}
