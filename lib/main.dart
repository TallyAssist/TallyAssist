import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/models/inactivecustomer.dart';
import 'package:tassist/core/models/payables.dart';
import 'package:tassist/core/models/receivables.dart';
import 'package:tassist/core/models/stockitem.dart';
import 'package:tassist/core/models/vouchers.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/core/services/database.dart';
import 'package:tassist/core/services/inactivecustomerservice.dart';
import 'package:tassist/core/services/payablesservice.dart';
import 'package:tassist/core/services/receivablesservice.dart';
import 'package:tassist/core/services/stockservice.dart';
import 'package:tassist/core/services/vouchers.dart';
import 'package:tassist/route_generator.dart';
import 'package:tassist/theme/texts.dart';
import 'core/models/ledger.dart';
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
        StreamProvider<List<ReceivablesItem>>.value(
          // initialData: List<ReceivablesItem>(),
          value: ReceivablesItemService(uid: user?.uid).accountsReceivableData,),
        StreamProvider<List<LedgerItem>>.value(
            value: LedgerItemService(uid: user?.uid).ledgerItemData),
        StreamProvider<List<StockItem>>.value(
            value: StockItemService(uid: user?.uid).stockItemsData),
        StreamProvider<List<PayablesItem>>.value(
            value: PayablesItemService(uid: user?.uid).accountsPayablesData),
        StreamProvider<List<InactiveCustomer>>.value(
            value: InactiveCustomerService(uid: user?.uid).inactiveCustomerData),
        // StreamProvider<List<SalesVoucher>>.value(
        //     value: SalesVoucherService(uid: user?.uid).salesVoucherData),
        // StreamProvider<List<PurchaseVoucher>>.value(
        //     value: PurchaseVoucherService(uid: user?.uid).purchaseVoucherData),
        // StreamProvider<List<PaymentVoucher>>.value(
        //     value: PaymentVoucherService(uid: user?.uid).paymentVoucherData),
        // StreamProvider<List<ReceiptVoucher>>.value(
        //     value: ReceiptVoucherService(uid: user?.uid).receiptVoucherData),
        StreamProvider<List<Voucher>>.value(
            value: VoucherService(uid: user?.uid).voucherData),
        StreamProvider<DocumentSnapshot>.value(
            value: DatabaseService()
                .companyCollection
                .document(user?.uid)
                .snapshots()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        // routes: {
        //   '/': (context) => RootPage(),
        //   '/vouchers': (context) => VouchersHome(),
        //   '/voucherview': (context) => VoucherView(),
        //   '/ledgerview': (context) => LedgerView(),
        //   '/ledgers': (context) => LedgerScreen()
        // },
        title: _title,
        // home: HomeScreen(),
        // home: RootPage(),
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
