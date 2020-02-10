
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/ui/root_page.dart';
import 'package:tassist/theme/texts.dart';



void main() {

 runApp(MyApp());
 }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String _title = "TallyAssist";

    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(value:  AuthService().user,),
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
      )
    );
  }
}
