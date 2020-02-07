import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';

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
                      Icon(Icons.share,
                        color: TassistPrimaryBackground,

                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
