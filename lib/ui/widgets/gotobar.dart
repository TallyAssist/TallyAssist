import 'package:flutter/material.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/theme/dimensions.dart';

class GoToBar extends StatelessWidget {
  final String goToText;
  final Widget widget;
  
  
  GoToBar(this.goToText, this.widget);
  

  @override
  Widget build(BuildContext context) {
    return  InkWell(
          onTap: () {Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                    builder: (context) => widget,
                  )
          );
          },

          child: Container(
              margin: spacer.y.xxs,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 20,
                      padding: spacer.left.xs,
                      color: TassistBgBlue,
                      child: Row(
                        children: <Widget>[
                          Text(goToText,
                          style: Theme.of(context).textTheme.body2.copyWith(
                            fontSize: 14
                          ),                       
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    color: TassistBgBlue,
                    child: 
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.arrow_right, color: Colors.purple[800])),
                  ),
                ],
              ),
            ),
    );
         }
}