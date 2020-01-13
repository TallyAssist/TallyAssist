import 'package:flutter/material.dart';

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border(
      top: BorderSide( //                    <--- top side
        color: Colors.blueGrey,
        width: 3.0,
      ),
    ),
  );
}