import '../../util/Login.dart';
import 'package:flutter/material.dart';

class DefaultDrawer extends StatelessWidget {
  final VoidCallback updateLocation;

  DefaultDrawer({this.updateLocation});

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        padding: const EdgeInsets.only(top: 30.0),
        children: <Widget>[
          new ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Edit my profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          new ListTile(
            leading: const Icon(Icons.subject),
            title: const Text('Requests'),
            onTap: () {
              Navigator.pushNamed(context, '/request');
            },
          ),
          new ListTile(
            leading: const Icon(Icons.send),
            title: const Text('Requests'),
            onTap: () {
              Navigator.pushNamed(context, '/sent');
            },
          ),
          new Divider(),
          new ListTile(
            leading: const Icon(Icons.power_settings_new),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              Login.logout(context);
            },
          ),
        ],
      ),
    );
  }
}
