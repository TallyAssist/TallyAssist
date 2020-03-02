import 'package:flutter/material.dart';
import 'package:tassist/ui/root_page.dart';
import 'package:tassist/ui/views/ledgerscreen.dart';
import 'package:tassist/ui/views/ledgerview.dart';
import 'package:tassist/ui/views/vouchers.dart';
import 'package:tassist/ui/views/voucherview.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final Map args = settings.arguments;

    switch (settings.name) {

      case '/':
        return MaterialPageRoute(builder: (_) => RootPage());

      case '/vouchers':
        return MaterialPageRoute(builder: (_) => VouchersHome());

      case '/voucherview':
        return MaterialPageRoute(
            builder: (_) => VoucherView(
                  voucherId: args['voucher_id_view'],
                  partyGuid: args['party_guid'],
                ));

      case '/ledgerview':
        return MaterialPageRoute(builder: (_) => LedgerView());

      case '/ledgers':
        return MaterialPageRoute(builder: (_) => LedgerScreen());

      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
