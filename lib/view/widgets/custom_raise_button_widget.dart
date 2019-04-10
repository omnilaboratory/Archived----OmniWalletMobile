import 'package:flutter/material.dart';
import 'package:wallet_app/tools/Tools.dart';

class CustomRaiseButton extends StatelessWidget {
  const CustomRaiseButton({
    Key key,
    @required this.context,
    this.callback,
    @ required this.title,
    this.titleSize=15.0,
    this.titleColor,
    this.leftIconName,
    this.rightIconName,
    this.color = Colors.transparent,
    this.height = 12.0
  }) : super(key: key);

  final BuildContext context;
  final Function callback;
  final String title;
  final num titleSize;
  final Color titleColor;
  final String leftIconName;
  final String rightIconName;

  /**
   * background color
   */
  final Color color;
  final num height;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        elevation: 0,
        highlightElevation: 0,
        onPressed: (){
          callback();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: this.createChildren(),
        ),
        color: color,
        padding: EdgeInsets.symmetric(vertical:height),
      ),
    );
  }

  List<Widget> createChildren(){
    List<Widget> list = [];
    if(this.leftIconName!=null){
      list.add(Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Image.asset(Tools.imagePath(this.leftIconName),width: 15,height: 15,),
      ));
    }
    list.add(Text(this.title ,style: TextStyle(fontSize: titleSize,color: titleColor),));
    if(this.rightIconName!=null){
      list.add(Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Image.asset(Tools.imagePath(this.rightIconName),width: 15,height: 15,),
      ));
    }
    return list;
  }
}