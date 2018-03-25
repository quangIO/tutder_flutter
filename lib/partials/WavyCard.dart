import 'package:flutter/material.dart';
import 'package:tutder/config/ThemeConfig.dart';


class WavyCard extends StatelessWidget {
  WavyCard({this.child, this.height});
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          decoration: new BoxDecoration(
            gradient: new LinearGradient(colors: GradientStyles.aqua),
          ),
          height: height,
        ),
        new ClipPath(
          child: new Container(
            decoration: new BoxDecoration(
              color: Colors.grey.shade200.withOpacity(0.4),
            ),
            height: height,
          ),
          clipper: new TopWaveClipper(),
        ),
        child
      ],
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    path.lineTo(0.0, size.height - 100);

    final firstControlPoint = new Offset(size.width / 4, size.height);
    final firstEndPoint = new Offset(size.width / 2, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    final secondControlPoint =
    new Offset(size.width - (size.width / 4), size.height - 55.0);
    final secondEndPoint = new Offset(size.width, size.height - 30.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}