import 'package:flutter/material.dart';
import '../../config/ThemeConfig.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final double elevation;
  final Widget child;
  final Color color;
  final Color shadowColor;
  final bool useShadow;
  final Gradient gradient;

  final double width;
  final double height;

  final List<BoxShadow> shadows;

  CustomButton(
      {this.child,
      this.onPressed,
      this.gradient = const LinearGradient(colors: GradientStyles.aqua),
      this.elevation = 10.0,
      this.color = Colors.black,
      this.shadowColor = Colors.black87,
      this.useShadow = true,
      this.width = 250.0,
      this.height = 60.0,
      this.shadows});

  @override
  State<StatefulWidget> createState() => new _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  double elevation;

  @override
  void initState() {
    elevation = widget.elevation;
    super.initState();
  }

  List<BoxShadow> _buildBoxShadow() {
    if (!widget.useShadow) return null;
    if (elevation == 0.0) return <BoxShadow>[];
    if (widget.shadows != null) {
      return widget.shadows;
    }
    return <BoxShadow>[
      new BoxShadow(
        color: widget.shadowColor,
        blurRadius: elevation,
        offset: new Offset(.3, 4.0),
        spreadRadius: -2.0,
      ),
    ];
  }

  _buildButtonDecoration() {
    return new BoxDecoration(
      color: widget.color,
      gradient: widget.gradient,
      borderRadius: new BorderRadius.circular(100.0),
      boxShadow: _buildBoxShadow(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Container(
        margin: const EdgeInsets.all(20.0),
        child: new Center(
          child: widget.child,
          widthFactor: 1.0,
        ),
        decoration: _buildButtonDecoration(),
        constraints: new BoxConstraints(
            minWidth: widget.width, minHeight: widget.height),
      ),
      onTap: widget.onPressed,
      onTapDown: (_) => setState(() => elevation = 0.0),
      onTapUp: (_) => setState(() => elevation = widget.elevation),
      onTapCancel: () => setState(() => elevation = widget.elevation),
    );
  }
}
