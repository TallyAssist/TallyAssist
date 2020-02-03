// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// 
// import 'package:tassist/ui/shared/drawer.dart';
// import 'package:tassist/ui/shared/headernav.dart';
// import 'package:tassist/ui/views/dashboard.dart';
// import 'package:tassist/ui/views/khatascreen.dart';
// import 'package:tassist/ui/views/menu.dart';
// import 'package:tassist/ui/views/partyscreen.dart';
// import 'package:tassist/ui/views/stockscreen.dart';




// class AboveDashboard extends StatefulWidget {
//   @override
//   _AboveDashboardState createState() => _AboveDashboardState();
// }

// class _AboveDashboardState extends State<AboveDashboard> {
//   final GlobalKey<ScaffoldState> _drawerKey = new GlobalKey<ScaffoldState>();


//   int _selectedPage = 0;
  
//   final _pageOptions = [
//     DashboardScreen(),
//     PartyScreen(),
//     KhataScreen(),
//     StockScreen(),
//     MenuScreen()
//   ];


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _drawerKey,
//         appBar: headerNav(_drawerKey),
//         drawer: tassistDrawer(context),
//         body: _pageOptions[_selectedPage],
//         bottomNavigationBar: BottomNavigationBar(
//     currentIndex: _selectedPage,
//     type: BottomNavigationBarType.fixed,
//     onTap: (int index) {
//       setState(() {
//         _selectedPage = index;
//       });
//     },
//     items: const <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(FontAwesomeIcons.tachometerAlt),
//         title: Text('MyReport'),
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(FontAwesomeIcons.building),
//         title: Text('Party'),
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(FontAwesomeIcons.book),
//         title: Text('Khata'),
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(FontAwesomeIcons.warehouse),
//         title: Text('Stock'),
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(FontAwesomeIcons.ellipsisH),
//         title: Text('More'),
//       )


      
//     )
//     );
//   }
// }
