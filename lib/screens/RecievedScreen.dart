import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tutder/config/HttpConfig.dart';
import 'package:tutder/config/ThemeConfig.dart';
import 'package:tutder/domain/User.dart';
import 'package:tutder/partials/MessageItem.dart';
import 'package:tutder/partials/WavyCard.dart';
import 'package:tutder/screens/drawer/DefaultDrawer.dart';
import 'package:tutder/util/Login.dart';
import 'package:http/http.dart' as http;

class RecievedScreen extends StatefulWidget {
  @override
  State createState() => new _RecievedState();
}

class _RecievedState extends State<RecievedScreen> {
  List<MessageItem> items = [];
  User me;

  _load() async {
    if (!mounted) return;
    items.clear();
    me = await Login.getUserInfo();
    http.Response response = await http.get(
      API.BASE_URL + "/secured/message/request",
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
    );
    Map<String, dynamic> body = json.decode(response.body);
    if (body['code']['value'] == 200) {
      setState(() {
        for (Map<String, dynamic> m in body['content']) {
          items.add(
            new MessageItem(
              question: m['content'],
              place: m['place'],
              isAccepted: m['accepted'],
              idx: m['id'],
            ),
          );
        }
      });
    } else {}
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  _buildHead(BuildContext context) {
    return new WavyCard(
      child: new Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 50.0),
        child: new Column(
          children: <Widget>[
            new Text(
              "",
              style: TextStyles.regularWhite,
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
      height: 350.0,
    );
  }

  _accept(int idx) async {
    http.Response response = await http.get(
      API.BASE_URL + "/secured/message/${items[idx].idx}",
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
    );
    Map<String, dynamic> body = json.decode(response.body);
    if (body['code']['value'] == 200) {
      setState(() {
        items[idx] = new MessageItem(
          idx: items[idx].idx,
          place: items[idx].place,
          isAccepted: true,
          question: items[idx].question,
        );
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey.shade900,
      drawer: new DefaultDrawer(refresh: _load,),
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            pinned: false,
            automaticallyImplyLeading: true,
            expandedHeight: 350.0,
            backgroundColor: Colors.transparent,
            title: new Text(
              "Altruistic Egoism",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 24.0,
              ),
            ),
            centerTitle: true,
            flexibleSpace: new FlexibleSpaceBar(
              centerTitle: true,
              background: new Column(
                children: <Widget>[
                  _buildHead(context),
                  // _buildInfoBar(),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return new GestureDetector(
                  child: items[index],
                  onDoubleTap: () {
                    _accept(index);
                  },
                );
              },
              childCount: items.length,
            ),
          ),
        ],
      ),
    );
  }
}
