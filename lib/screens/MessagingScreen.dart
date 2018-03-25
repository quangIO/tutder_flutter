import 'dart:convert';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tutder/config/HttpConfig.dart';
import 'package:tutder/config/ThemeConfig.dart';
import 'package:tutder/domain/User.dart';
import 'package:tutder/partials/BottomWaveClipper.dart';
import 'package:tutder/screens/LoadingScreen.dart';
import 'package:tutder/screens/drawer/DefaultDrawer.dart';
import 'package:tutder/util/Login.dart';
import 'package:http/http.dart' as http;

class MessagingScreen extends StatefulWidget {
  final String username;

  MessagingScreen(this.username);

  @override
  State createState() => new _MessagingState();
}

class _MessagingState extends State<MessagingScreen> {
  final questionTextController = new TextEditingController();
  final placeTextController = new TextEditingController();
  User me;
  List skills = [];
  Map user;

  _loadUser() {
    http
        .get(
      API.USER_LIST_URL + widget.username,
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
    )
        .then(
      (response) {
        Map<String, dynamic> body = json.decode(response.body);
        if (body['code']['value'] == 200) {
          setState(() => user = body['content']);
        } else {}
      },
    );
  }

  _loadSkill() async {
    me = await Login.getUserInfo();
    http.Response response = await http.get(
      API.SKILL_VIEW_URL + widget.username,
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
    );
    Map<String, dynamic> body = json.decode(response.body);
    if (body['code']['value'] == 200) {
      setState(() {
        skills = body['content'];
      });
      _loadUser();
    } else {}
  }

  Widget _buildAvatar() {
    if (user == null) {
      return new LoadingScreen();
    }
    return new ClipPath(
      child: new Container(
        child: new Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              new CircleAvatar(
                backgroundImage: new NetworkImage(user['imageUrl'] ??
                    'https://api.adorable.io/avatars/285/' +
                        Random.secure().nextInt(1000).toString()),
                radius: 85.0,
              )
            ],
          ),
        ),
        height: 300.0,
        decoration: new BoxDecoration(
          // color: Colors.grey
          gradient: new LinearGradient(
            begin: AlignmentDirectional.bottomStart,
            end: AlignmentDirectional.topEnd,
            colors: GradientStyles.redGradient,
          ),
        ),
      ),
      clipper: new BottomWaveClipper(),
    );
  }

  _send() async {
    debugPrint("OK");
    http.Response response = await http.post(
      API.BASE_URL + '/secured/message/create',
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
      body: json.encode({
        'content': questionTextController.text,
        'place': placeTextController.text,
        'recipient': widget.username,
      }),
    );
    Map<String, dynamic> body = json.decode(response.body);
    if (body['code']['value'] == 200) {
      Navigator.pop(context);
    } else {
      showBottomSheet(
          context: context,
          builder: (builder) {
            return new Text("Error");
          });
    }
    //questionTextController.clear();
    //placeTextController.clear();
  }

  @override
  void initState() {
    super.initState();
    _loadSkill();
  }

  @override
  Widget build(BuildContext context) {
    final strengths =
        skills.where((skill) => skill['level'] == "STRONG").toList();
    final weaknesses =
        skills.where((skill) => skill['level'] == "WEAK").toList();
    return new Scaffold(
      backgroundColor: Colors.grey.shade900,
      drawer: new DefaultDrawer(),
      body: new Column(
        children: <Widget>[
          _buildAvatar(),
          new Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: new TextField(
              style: TextStyles.buttonWhite,
              controller: questionTextController,
              autofocus: false,
              maxLength: 256,
              decoration: new InputDecoration(
                  counterStyle:
                      TextStyles.messageContent.copyWith(fontSize: 9.0),
                  hintText: "Your question",
                  hintStyle: TextStyles.regularWhite
                      .copyWith(color: Colors.white.withOpacity(.4))),
            ),
          ),
          new Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: new TextField(
              style:
                  TextStyles.regularWhite.copyWith(fontWeight: FontWeight.w100),
              controller: placeTextController,
              autofocus: false,
              decoration: new InputDecoration(
                  hintText: "Place to meet",
                  hintStyle: TextStyles.regularWhite
                      .copyWith(color: Colors.white.withOpacity(.4))),
            ),
          ),
          new Divider(
            color: Colors.transparent,
            height: 32.0,
          ),
          new Center(
            child: new Text(
              "GOOD AT",
              style: TextStyles.regularWhite.copyWith(color: Colors.green),
            ),
          ),
          new Container(
            height: 64.0,
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new FlatButton(
                  onPressed: null,
                  child: new Text(
                    strengths[index]['name'],
                    style: TextStyles.infoContent,
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: strengths.length,
            ),
          ),
          new Divider(
            color: Colors.transparent,
            height: 32.0,
          ),
          new Center(
            child: new Text(
              "BAD AT",
              style: TextStyles.regularWhite.copyWith(color: Colors.red),
            ),
          ),
          new Container(
            height: 64.0,
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new FlatButton(
                  onPressed: null,
                  child: new Text(
                    weaknesses[index].name,
                    style: TextStyles.infoContent,
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: weaknesses.length,
            ),
          ),
          /*
          new ListView.builder(
            itemBuilder: (BuildContext context, int index) {},
            scrollDirection: Axis.horizontal,
            itemCount: weaknesses.length,
          ),
          */
        ],
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          _send();
        },
        child: new Icon(Icons.message),
      ),
    );
  }
}
