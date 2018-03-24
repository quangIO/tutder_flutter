import 'package:flutter/material.dart';
import 'package:tutder/components/PageTransformer.dart';
import 'package:tutder/domain//User.dart';
import 'package:tutder/partials/UserPage.dart';

class UserFeedScreen extends StatelessWidget {
  final sampleItems = [
    User("quangio",
        imageUrl: 'http://d3iw72m71ie81c.cloudfront.net/female-33.jpg'),
    User("quangi2",
        imageUrl: 'http://d3iw72m71ie81c.cloudfront.net/female-42.jpg'),
    User("quangi3", intro: "hih"),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Column(
        children: <Widget>[
          new Flexible(
              child: PageTransformer(
                pageViewBuilder: (context, visibilityResolver) {
                  return PageView.builder(
                    controller: new PageController(viewportFraction: 0.85),
                    itemCount: sampleItems.length,
                    itemBuilder: (context, index) {
                      final item = sampleItems[index];
                      final pageVisibility =
                          visibilityResolver.resolvePageVisibility(index);
                      return UserPage(
                        user: item,
                        pageVisibility: pageVisibility,
                      );
                    },
                  );
                },
              //),
            ),
          ),
          new MaterialButton(onPressed: null, child: new Text('Contact'),),
        ],
      ),
    );
  }
}
