
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String msg;

  const LoadingScreen({this.msg = "Loading..."});

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularProgressIndicator(strokeWidth: 2.0),
        ],
      ),
    );
  }
}
