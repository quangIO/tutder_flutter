import 'package:flutter/material.dart';

class CustomFormTitle extends StatelessWidget {
  final String textContent;

  CustomFormTitle({this.textContent});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(
        textContent,
        textAlign: TextAlign.center,
        style: new TextStyle(
          fontWeight: FontWeight.w200,
          color: Colors.white,
          fontSize: 60.0,
        ),
        overflow: TextOverflow.fade,
      ),
      margin: const EdgeInsets.only(bottom: 40.0),
    );
  }
}
