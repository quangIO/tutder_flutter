import '../screens/UserProfileSettingScreen.dart';
import '../screens/UserFeedScreen.dart';
import '../screens/LoginPage.dart';
import '../screens/RegisterPage.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

final router = new Router();

class BaseRouterHandler {
  final _loginHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) => new LoginPage());
  final _homeHandler = new Handler(
      handlerFunc: (_, Map<String, dynamic> params) => new UserFeedScreen());
  final _registerHandler = new Handler(
      handlerFunc: (_, Map<String, dynamic> params) => new RegisterPage());
  final _profileHandler = new Handler(
      handlerFunc: (_, Map<String, dynamic> params) => new UserProfileSettingScreen());

  BaseRouterHandler() {
    router.define("/login", handler: _loginHandler);
    router.define("/home", handler: _homeHandler);
    router.define("/register", handler: _registerHandler);
    router.define("/profile", handler: _profileHandler);
  }
  BaseRouterHandler._internal();
}



