import 'dart:convert';
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tutder/components/PageTransformer.dart';
import 'package:tutder/config/HttpConfig.dart';
import 'package:tutder/config/RouteSingleton.dart';
import 'package:tutder/domain/User.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  UserPage(
      {@required this.user,
      @required this.pageVisibility,
      @required this.me,
      @required this.propagate,
      @required this.idx});

  final Map user;
  final PageVisibility pageVisibility;
  final User me;
  final Function(int, int) propagate;
  final int idx;

  @override
  State createState() => new _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isLoved = false;
  int loveCount = 0;

  @override
  void initState() {
    super.initState();
    setState(() {
      isLoved = widget.user['extra']['is_loved'];
      loveCount = widget.user['loved'];
    });
  }

  Widget _applyTextEffects({
    @required double translationFactor,
    @required Widget child,
  }) {
    final double xTranslation =
        widget.pageVisibility.pagePosition * translationFactor;

    return new Opacity(
      opacity: widget.pageVisibility.visibleFraction,
      child: new Transform(
        alignment: FractionalOffset.topLeft,
        transform: new Matrix4.translationValues(xTranslation, 0.0, 0.0),
        child: child,
      ),
    );
  }

  _love() async {
    http.Response response = await http.get(
      API.USER_LIST_URL + widget.user['username'].toString() + '/love',
      headers: new CombinedMapView([
        {'cookie': widget.me.session},
        API.DEFAULT_HEADER
      ]),
    );

    Map<String, dynamic> body = json.decode(response.body);
    if (body['code']['value'] == 200) {
      widget.propagate(widget.idx, loveCount);

      setState(() {
        isLoved = true;
        loveCount = body['content'];
      });
    } else {
      // TODO
    }
  }

  _buildLoved(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final lovedCount = _applyTextEffects(
      translationFactor: 30.0,
      child: new Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: new Text(
          loveCount.toString(),
          style: textTheme.title
              .copyWith(color: Colors.white, fontWeight: FontWeight.w100),
          textAlign: TextAlign.center,
        ),
      ),
    );
    final heartButton = isLoved
        ? new IconButton(
            icon: new Icon(Icons.favorite),
            color: Colors.purple,
            onPressed: () {
              debugPrint('implement me');
            },
          )
        : new IconButton(
            icon: new Icon(Icons.favorite_border),
            color: Colors.purple,
            onPressed: () {
              _love();
            },
          );
    return new Positioned(
      bottom: 0.0,
      //left: 32.0,
      right: 0.0,
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          lovedCount,
          heartButton,
        ],
      ),
    );
  }

  _buildTextFooter(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final categoryText = _applyTextEffects(
      translationFactor: 900.0,
      child: new Text(
        widget.user['info'],
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
          widget.user['username'].toString().toUpperCase(),
          style: textTheme.title
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );

    final description = _applyTextEffects(
      translationFactor: 30.0,
      child: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 14.0),
        child: new Text(
          widget.user['description'].toString(),
          style: textTheme.title
              .copyWith(color: Colors.white, fontWeight: FontWeight.w300),
          textAlign: TextAlign.left,
        ),
      ),
    );
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Flexible(child: description),
        new Container(
          margin: new EdgeInsets.only(bottom: 18.0),
          child: new Column(
            children: <Widget>[
              categoryText,
              new GestureDetector(
                child: titleText,
                onHorizontalDragEnd: (e) {
                  //.pushNamed(context, "/message/" + widget.user['username']);
                  // debugPrint("/message/${widget.user['username']}");
                  router.navigateTo(context, "/message/${widget.user['username']}", transition: TransitionType.inFromBottom);
                },
                onDoubleTap: () {
                  router.navigateTo(context, "/message/${widget.user['username']}", transition: TransitionType.inFromBottom);
                },
              )
            ],
          ),
        )
      ],
    );
    /*
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
    */
  }

  @override
  Widget build(BuildContext context) {
    // ignore: conflicting_dart_import
    final image = new Image.network(
      widget.user['imageUrl'],
      fit: BoxFit.cover,
      alignment: new FractionalOffset(
          0.5 + (widget.pageVisibility.pagePosition / 3), 0.5),
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
      filter: new ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
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
            _buildLoved(context),
          ],
        ),
      ),
    );
  }
}
