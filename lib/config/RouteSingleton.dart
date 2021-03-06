import 'package:tutder/screens/MessagingScreen.dart';
import 'package:tutder/screens/RecievedScreen.dart';
import 'package:tutder/screens/SentScreen.dart';

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

  final _messagingHandler = new Handler(
      handlerFunc: (_, Map<String, dynamic> params) {
        return new MessagingScreen(params['username'].toString().replaceFirst("[", "").replaceFirst("]", ""));
      });
  final _requestHandler = new Handler(
      handlerFunc: (_, Map<String, dynamic> params) => new RecievedScreen());
  final _sendHandler = new Handler(
      handlerFunc: (_, Map<String, dynamic> params) => new SentScreen());

  BaseRouterHandler() {
    router.define("/login", handler: _loginHandler);
    router.define("/home", handler: _homeHandler);
    router.define("/register", handler: _registerHandler);
    router.define("/profile", handler: _profileHandler);
    router.define("/request", handler: _requestHandler);
    router.define("/send", handler: _sendHandler);
    router.define("/message/:username", handler: _messagingHandler);
  }
  BaseRouterHandler._internal();
}



