import 'package:flutter/material.dart';

class TextStyles {
  const TextStyles();

  static const TextStyle messageContent = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
  );

  static const TextStyle infoContent = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w200,
    fontSize: 20.0,
  );

  static const TextStyle messageUsername = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 20.0,
  );
  static const TextStyle buttonWhite = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 24.0,
  );
  static const TextStyle regularWhite = const TextStyle(
    color: Colors.white,
    fontFamily: 'Poppins',
    fontSize: 20.0,
  );

  static const TextStyle titleBlack = const TextStyle(
    color: Colors.black,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w700,
    fontSize: 18.0,
  );

  static const TextStyle descriptionBlack = const TextStyle(
    color: Colors.grey,
    // fontFamily: 'Poppins',
    fontSize: 12.0,
  );
}

class GradientStyles {
  static final List<Color> fuchsia = [
    Colors.purple.shade600,
    Colors.deepPurple.shade500,
  ];

  static const List<Color> aqua = const [
    //const Color(0xff2196f3),
    const Color(0xff21f3e7),
    const Color(0xff2196f3),
    //const Color(0xff212df3),
  ];
  static const List<Color> backgroundGradientLogin = const [
    const Color(0xff515772),
    const Color(0xff383c51)
  ];
  static const List<Color> redGradient = const [Colors.grey, Colors.blueGrey];
  static const List<List<Color>> messageCardColors = const [
    const [Colors.deepPurpleAccent, Colors.deepPurple],
    const [Colors.deepOrangeAccent, Colors.deepOrange],
    const [Colors.blueAccent, Colors.blue]
  ];
}

class ShadowStyles {
  static final shadow2 = <BoxShadow>[
    new BoxShadow(
      color: Colors.grey[200],
      blurRadius: 7.0,
      spreadRadius: -7.0,
      offset: new Offset(1.0, -15.0),
    ),
    new BoxShadow(
      color: Colors.grey[300],
      blurRadius: 5.0,
      spreadRadius: -3.0,
      offset: new Offset(0.0, 10.0),
    ),
    new BoxShadow(
      color: Colors.grey[400],
      blurRadius: 10.0,
      spreadRadius: -3.0,
      offset: new Offset(0.0, 10.0),
    ),
  ];
}
