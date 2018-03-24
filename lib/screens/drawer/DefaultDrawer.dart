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
            title: const Text('My profile'),
            onTap: () {
              Login.getUserInfo().then((u){
                Navigator.pushNamed(context, '/user/${u.username}');
              });
            },
          ),
          new ListTile(
            leading: const Icon(Icons.my_location),
            title: const Text('Refresh location'),
            onTap: updateLocation,
          ),
          new ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Places near me'),
            onTap: () {
              Navigator.pushNamed(context, '/places');
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
