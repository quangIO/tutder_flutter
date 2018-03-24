import '../config/RouteSingleton.dart';
import 'package:fluro/fluro.dart';

import '../partials/form/CustomButton.dart';
import '../partials/form/CustomFormTitle.dart';
import '../partials/form/CustomTextField.dart';
import '../config/ThemeConfig.dart';
import '../util/Login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();

  _checkLogin() async {
    if (await Login.isLoggedIn() && await Login.refreshUser()) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  _login(BuildContext ctx) async {
    String username = _usernameController.text;
    String password = _passwordController.text;
    Map loginMessage = await Login.loginUser(username, password);
    if (loginMessage['code']['value'] != 200) {
      _showInSnackBar(ctx, loginMessage['content']);
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  _showInSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
          new SnackBar(
            content: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Text(message),
                new Icon(Icons.error),
              ],
            ),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
  }

  Widget _buildBody(BuildContext context) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CustomFormTitle(
            textContent: 'Welcome',
          ),
          new CustomTextField(
            controller: _usernameController,
            hintText: 'Username',
            icon: const Icon(
              Icons.person_outline,
              color: Colors.redAccent,
            ),
          ),
          new CustomTextField(
            controller: _passwordController,
            hintText: 'Password',
            icon: const Icon(
              Icons.lock_outline,
              color: Colors.redAccent,
            ),
            obscure: true,
          ),
          new Hero(
            child: new CustomButton(
              child: new Text(
                'Login',
                style: TextStyles.buttonWhite,
              ),
              onPressed: () => _login(context),
            ),
            tag: "auth-button",
          ),
          new Container(
            child: new FlatButton(
              onPressed: () => router.navigateTo(context, '/register',
                  transition: TransitionType.fadeIn),
              child: new Text(
                'Sign me up',
                style: TextStyles.regularWhite,
              ),
            ),
            margin: const EdgeInsets.only(top: 30.0),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      decoration: new BoxDecoration(
        gradient: new RadialGradient(
          colors: GradientStyles.backgroundGradientLogin,
          radius: 1.2,
          center: Alignment.topCenter,
          stops: [0.0, 1.0],
        ),
      ),
    );
  }

  @override
  initState() {
    _checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Builder(
        builder: _buildBody,
      ),
    );
  }
}
