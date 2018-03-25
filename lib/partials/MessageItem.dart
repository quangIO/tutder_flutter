import 'package:flutter/material.dart';
import 'package:tutder/config/ThemeConfig.dart';


class MessageItem extends StatelessWidget {
  MessageItem({this.question, this.place});

  final String question, place;

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      margin: new EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
      padding: new EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
      child: new Column(
        children: <Widget>[
          new Text(question, style: TextStyles.buttonWhite),
          new Text(place, style: TextStyles.infoContent,),
        ],
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.deepPurpleAccent.withOpacity(0.2),
        borderRadius: new BorderRadius.circular(65.0),
      ),
    );
  }
}