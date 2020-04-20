import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';
// import 'package:screenshot_and_share/screenshot_share.dart';


class SectionHeader extends StatelessWidget {

  final sectionText;

  SectionHeader(this.sectionText);

 
  @override
  Widget build(BuildContext context) {


    return Container(
            padding: EdgeInsets.all(10.0),
            color: TassistBgLightPurple,
            height: 50.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        sectionText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: TassistPrimary, 
                            fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      // Icon(
                      //   Icons.favorite,
                      //   color: TassistPrimaryBackground,
                      // ),
                      // Icon(
                      //   Icons.bookmark,
                      //   color: TassistPrimaryBackground,
                      // ),
                      // IconButton(
                      //   icon: Icon(Icons.share),
                      //   color: TassistPrimaryBackground,
                      //   onPressed: () => ScreenshotShare.takeScreenshotAndShare(),
                        
                      //   // () => showDialog(
                      //   //   context: context,
                      //   //   builder: (context) {
                      //   //    return AlertDialog(
                      //   //         title: Text('Coming soon!'),
                      //   //         actions: 
                      //   //         <Widget>[
                      //   //           FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('Ill wait :)'))
                      //   //         ]
                      //   //     );
                      //   //   },
                        
                      //   // ),

                      // ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
