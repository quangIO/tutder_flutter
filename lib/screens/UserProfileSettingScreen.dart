import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tutder/config/HttpConfig.dart';
import 'package:tutder/config/ThemeConfig.dart';
import 'package:tutder/domain/Skill.dart';
import 'package:tutder/domain/User.dart';
import 'package:tutder/partials/BottomWaveClipper.dart';
import 'package:tutder/screens/drawer/DefaultDrawer.dart';
import 'package:tutder/util/Login.dart';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:tutder/util/MediaUtils.dart';

class UserProfileSettingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _UserProfileSettingState();
}

class _UserProfileSettingState extends State<UserProfileSettingScreen> {
  TextEditingController infoTextController = new TextEditingController();
  TextEditingController descriptionTextController = new TextEditingController();
  List skills = [];
  User me;
  String url;

  _initInfo() async {
    me = await Login.getUserInfo();
    http.Response response = await http.get(
      API.BASE_URL + '/secured/skill/list',
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
    );
    if(!mounted) return;
    Map<String, dynamic> body = json.decode(response.body);
    if (body['code']['value'] == 200) {
      setState(() {
        skills = body['content'];
      });
    } else {}
  }

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
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              new CircleAvatar(
                backgroundImage: new NetworkImage(url ??
                    'https://api.adorable.io/avatars/285/' +
                        Random.secure().nextInt(1000).toString()),
                radius: 85.0,
              ),
              new IconButton(
                icon: new Icon(Icons.edit),
                color: new Color.fromARGB(144, 12, 23, 33),
                onPressed: () {
                  MediaUtils.upload('?avatar=1').then((u) => setState(() => url = u));
                },
                iconSize: 38.0,
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

  addSkill(Map skill, [String level = "STRONG"]) {
    Map tmp = skill;
    tmp['level'] = level;
    http.post(
      API.SKILL_URL_CREATE,
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
      body: json.encode(skill),
    );
    setState(() => skills.remove(skill));
  }

  updateUser() {
    http.post(
      API.USER_UPDATE_URL,
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
      body: json.encode({
        'description': descriptionTextController.text,
        'info': infoTextController.text,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              "CLEAR YOUR STRENGTHS",
              style: TextStyles.regularWhite.copyWith(color: Colors.green),
            ),
          ),
          new Container(
            height: 64.0,
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new FlatButton(
                  onPressed: () => addSkill(skills[index]),
                  child: new Text(
                    skills[index]['name'],
                    style: TextStyles.infoContent,
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: skills.length,
            ),
          ),
          new Divider(
            color: Colors.transparent,
            height: 32.0,
          ),
          new Center(
            child: new Text(
              "CLEAR YOUR WEAKNESSES",
              style: TextStyles.regularWhite.copyWith(color: Colors.red),
            ),
          ),
          new Container(
            height: 64.0,
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return new FlatButton(
                  onPressed: () {
                    addSkill(skills[index], "WEAK");
                  },
                  child: new Text(
                    skills[index]['name'],
                    style: TextStyles.infoContent,
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
              itemCount: skills.length,
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
          updateUser();
          Navigator.pushReplacementNamed(context, '/home');
        },
        child: new Icon(Icons.arrow_right),
      ),
    );
  }
}
