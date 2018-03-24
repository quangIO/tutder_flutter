import 'package:flutter/material.dart';
import '../../config/ThemeConfig.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon icon;
  final bool obscure;
  final String errorText;

  final ValueChanged<String> onChanged;

  CustomTextField({
    this.controller,
    this.hintText,
    this.icon,
    this.obscure = false,
    this.errorText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyles.regularWhite,
        autocorrect: false,
        decoration: new InputDecoration(
          icon: icon,
          hintText: hintText,
          errorText: errorText,
        ),
        onChanged: onChanged,
      ),
      /*
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.elliptical(30.0, 30.0)),
        color: Colors.white,
        gradient: new LinearGradient(
          colors: [Colors.white, Colors.white70],
          begin: const FractionalOffset(0.6, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
        ),
      ),
      padding: const EdgeInsets.only(bottom: 8.0),

      */
      margin: const EdgeInsets.only(bottom: 20.0),
    );
  }
}
