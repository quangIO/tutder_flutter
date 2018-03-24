import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:tutder/components/PageTransformer.dart';
import 'package:tutder/config/HttpConfig.dart';
import 'package:tutder/domain/User.dart';
import 'package:tutder/partials/UserPage.dart';
import 'package:tutder/screens/drawer/DefaultDrawer.dart';
import 'package:http/http.dart' as http;
import 'package:tutder/util/Login.dart';

class UserFeedScreen extends StatefulWidget {
  @override
  State createState() => new _UserFeedState();
}

class _UserFeedState extends State<UserFeedScreen> {
  List users = [
    /*
    User("quangio",
        imageUrl: 'http://d3iw72m71ie81c.cloudfront.net/female-33.jpg'),
    User("quangi2",
        imageUrl: 'http://d3iw72m71ie81c.cloudfront.net/female-42.jpg'),
    User("quangi3", intro: "hih"),
    */
  ];

  User me;

  _getUsers() async {
    me = await Login.getUserInfo();
    http.Response response = await http.get(
      API.USER_LIST_URL,
      headers: new CombinedMapView([
        {'cookie': me.session},
        API.DEFAULT_HEADER
      ]),
    );
    Map<String, dynamic> body = json.decode(response.body);
    if (body['code']['value'] == 200) {
        debugPrint(body['content'][0].toString());
        for (Map u in body['content']){
          users.add(u);
        }
        setState((){});
    } else {

    }
  }

  @override
  void initState() {
    super.initState();
    _getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new DefaultDrawer(),
      body: Column(
        children: <Widget>[
          new Flexible(
            child: PageTransformer(
              pageViewBuilder: (context, visibilityResolver) {
                return PageView.builder(
                  controller: new PageController(viewportFraction: 0.85),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final item = users[index];
                    final pageVisibility =
                        visibilityResolver.resolvePageVisibility(index);
                    return UserPage(
                      user: item,
                      pageVisibility: pageVisibility,
                    );
                  },
                );
              },
            ),
          ),
          new MaterialButton(
            onPressed: null,
            child: new Text('Contact'),
          ),
        ],
      ),
    );
  }
}
