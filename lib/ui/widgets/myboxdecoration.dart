import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';

BoxDecoration myBoxDecorationTopBorder() {
  return BoxDecoration(
    border: Border(
      top: BorderSide(
        //                    <--- top side
        color: Colors.blueGrey,
        width: 3.0,
      ),
    ),
  );
}

BoxDecoration myBoxDecorationBottomBorder() {
  return BoxDecoration(
    // border: Border(
    //   bottom: BorderSide(
    //     color: Colors.blueGrey,
    //     width: 3.0,
    //   ),
    // ),
    color: TassistBgLightPurple,
    shape: BoxShape.rectangle,
  );
}
