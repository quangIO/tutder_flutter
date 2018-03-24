import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tutder/components/PageTransformer.dart';
import 'package:tutder/domain//User.dart';

class UserPage extends StatelessWidget {
  UserPage({
    @required this.user,
    @required this.pageVisibility,
  });

  final Map user;
  final PageVisibility pageVisibility;

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation = pageVisibility.pagePosition * translationFactor;

    return new Opacity(
      opacity: pageVisibility.visibleFraction,
      child: new Transform(
        alignment: FractionalOffset.topLeft,
        transform: new Matrix4.translationValues(xTranslation, 0.0, 0.0),
        child: child,
      ),
    );
  }

  _buildTextFooter(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final categoryText = _applyTextEffects(
      translationFactor: 300.0,
      child: new Text(
        user['info'],
        style: textTheme.caption.copyWith(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          letterSpacing: 2.0,
          fontSize: 14.0,
        ),
        textAlign: TextAlign.center,
      ),
    );

    final titleText = _applyTextEffects(
      translationFactor: 200.0,
      child: new Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: new Text(
          user['username'],
          style: textTheme.title
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );

    return new Positioned(
      bottom: 56.0,
      left: 32.0,
      right: 32.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          categoryText,
          titleText,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: conflicting_dart_import
    final image = new Image.network(
      user['imageUrl'],
      fit: BoxFit.cover,
      alignment:
          new FractionalOffset(0.5 + (pageVisibility.pagePosition / 3), 0.5),
    );

    final imageOverlayGradient = const DecoratedBox(
      decoration: const BoxDecoration(
        gradient: const LinearGradient(
          begin: FractionalOffset.bottomCenter,
          end: FractionalOffset.topCenter,
          colors: [const Color(0xFF000000), const Color(0x00000000)],
        ),
      ),
    );

    final frostedGlassFilter = new BackdropFilter(
      filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
      child: new Container(
        decoration: new BoxDecoration(color: Colors.grey[200].withOpacity(0.1)),
      ),
    );


    return new Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: new Material(
        elevation: 4.0,
        borderRadius: new BorderRadius.circular(8.0),
        child: new Stack(
          fit: StackFit.expand,
          children: [
            image,
            frostedGlassFilter,
            imageOverlayGradient,
            _buildTextFooter(context),
          ],
        ),
      ),
    );
  }
}
