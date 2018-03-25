import 'dart:convert';

import '../partials/form/CustomButton.dart';
import '../partials/form/CustomFormTitle.dart';
import '../partials/form/CustomTextField.dart';
import '../config/HttpConfig.dart';
import '../config/ThemeConfig.dart';
import '../util/Login.dart';
import '../util/validation/ValidationMessage.dart';
import '../util/validation/Validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _passwordConfirmController = new TextEditingController();
  Map errorMessages = {};

  _register(BuildContext ctx) async {
    final String username = _usernameController.text;
    String email = _emailController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _passwordConfirmController.text;
    final ValidationMessage validateUsername =
        Validator.validateUsername(username);
    final ValidationMessage validateEmail = Validator.validateEmail(email);
    final ValidationMessage validatePassword =
        Validator.validatePassword(password, confirmPassword);

    bool isValid = true;
    if (email.isEmpty) email = null;
    if (!validateUsername.successful) {
      isValid = false;
      setState(() => errorMessages['username'] = validateUsername.message);
    }
    if (!validateEmail.successful) {
      isValid = false;
      setState(() => errorMessages['email'] = validateEmail.message);
    }
    if (!validatePassword.successful) {
      isValid = false;
      setState(() => errorMessages['password'] = validatePassword.message);
    }
    if (!isValid) return;

    http.Response response = await http.post(
      API.REGISTER_URL,
      headers: API.DEFAULT_HEADER,
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    Map<String, dynamic> body = json.decode(response.body);
    switch (body['code']['value']) {
      case 201:
        Map loginMessage = await Login.loginUser(username, password);
        if (loginMessage['code']['value'] != 200) {
          debugPrint(loginMessage['content']);
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          debugPrint('Navigate to Home');
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/profile');
        }
        break;
      default:
        _showInSnackBar(ctx, body['content']);
    }
  }

  void _showInSnackBar(BuildContext context, String message) {
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
            textContent: 'Open Knowledge',
          ),
          new CustomTextField(
            controller: _usernameController,
            hintText: 'Username',
            icon: const Icon(
              Icons.person_outline,
              color: Colors.lightBlue,
            ),
            errorText: errorMessages['username'],
            onChanged: (_) => setState(() => errorMessages['username'] = null),
          ),
          new CustomTextField(
            controller: _passwordController,
            hintText: 'Password',
            icon: const Icon(
              Icons.lock_outline,
              color: Colors.lightBlue,
            ),
            errorText: errorMessages['password'],
            onChanged: (_) => setState(() => errorMessages['password'] = null),
            obscure: true,
          ),
          new CustomTextField(
            controller: _passwordConfirmController,
            hintText: 'Confirm password',
            icon: const Icon(
              Icons.compare,
              color: Colors.lightBlue,
            ),
            obscure: true,
          ),
          new CustomTextField(
            controller: _emailController,
            hintText: 'Email (optional)',
            icon: const Icon(
              Icons.mail_outline,
              color: Colors.lightBlue,
            ),
            errorText: errorMessages['email'],
            onChanged: (_) => setState(() => errorMessages['email'] = null),
          ),
          new Hero(
            child: new CustomButton(
              child: new Text(
                'Register',
                style: TextStyles.buttonWhite,
              ),
              onPressed: () => _register(context),
              gradient: new LinearGradient(colors: GradientStyles.fuchsia),
            ),
            tag: "auth-button",
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
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Builder(
        builder: _buildBody,
      ),
    );
  }
}
