import 'package:flutter/material.dart';
import 'package:tutder/config/ThemeConfig.dart';
import 'package:tutder/partials/BottomWaveClipper.dart';
import 'dart:math';

import 'package:tutder/util/MediaUtils.dart';

class UserProfileSettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _UserProfileSettingState();
}

class _UserProfileSettingState extends State<UserProfileSettingScreen> {
  TextEditingController infoTextController;
  TextEditingController descriptionTextController;
  final List<String> strengths = [
    "Computer Science",
    "Nah",
    "Computer Science",
    "Nah"
  ];
  final List<String> weaknesses = ["Everything else"];

  _initInfo() async {}

  @override
  void initState() {
    super.initState();
    _initInfo();
  }

  Widget _buildAvatar() {
    return new ClipPath(
      child: new Container(
        child: new Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              new CircleAvatar(
                backgroundImage: new NetworkImage(
                    'https://api.adorable.io/avatars/285/' +
                        Random.secure().nextInt(1000).toString()),
                radius: 85.0,
              ),
              new IconButton(
                icon: new Icon(Icons.add),
                color: new Color.fromARGB(144, 12, 23, 33),
                onPressed: () {
                  MediaUtils.upload('?avatar=1');
                },
                iconSize: 88.0,
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey.shade900,
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
              controller: infoTextController,
              autofocus: false,
              maxLength: 256,
              decoration: new InputDecoration(
                  counterStyle:
                      TextStyles.messageContent.copyWith(fontSize: 9.0),
                  hintText: "Summary",
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
              controller: descriptionTextController,
              autofocus: false,
              decoration: new InputDecoration(
                  hintText: "Description",
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
              "I AM GOOD AT",
              style: TextStyles.regularWhite.copyWith(color: Colors.green),
            ),
          ),
          new Container(
            height: 64.0,
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new FlatButton(
                  onPressed: () {},
                  child: new Text(
                    strengths[index],
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
              "I AM BAD AT",
              style: TextStyles.regularWhite.copyWith(color: Colors.red),
            ),
          ),
          new Container(
            height: 64.0,
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new FlatButton(
                  onPressed: () {},
                  child: new Text(
                    weaknesses[index],
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
        onPressed: () {},
        child: new Icon(Icons.arrow_right),
      ),
    );
  }
}
