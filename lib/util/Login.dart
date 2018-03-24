import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';

import '../config/HttpConfig.dart';
import '../domain/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login {
  static Future<bool> isLoggedIn() async {
    final pref = await SharedPreferences.getInstance();
    String session = pref.getString('session') ?? '';
    return session.isNotEmpty;
  }

  static Future<User> getUserInfo() async {
    final pref = await SharedPreferences.getInstance();
    return new User(
      pref.getString('username'),
      session: pref.getString('session'),
    );
  }

  static logout(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    pref.remove('session');
    pref.remove('username');
    pref.remove('email');
    Navigator.pushReplacementNamed(context, '/login');
  }

  static Future<bool> refreshUser() async {
    final pref = await SharedPreferences.getInstance();
    http.Response response = await http.get(
      API.REFRESH_URL,
      headers: new CombinedMapView([{'cookie': pref.getString('session')}, API.DEFAULT_HEADER]),
    );
    Map<String, dynamic> body = json.decode(response.body);
    switch (body['code']['value']) {
      case 200:
        Cookie cookie =
            new Cookie.fromSetCookieValue(response.headers['set-cookie']);
        pref.setString('session', cookie.toString());
        return true;
    }
    return false;
  }

  static Future<Map> loginUser(String username, String password) async {
    final pref = await SharedPreferences.getInstance();
    http.Response response = await http.post(
      API.LOGIN_URL,
      headers: API.DEFAULT_HEADER,
      body: json.encode({
        'username': username.toLowerCase(),
        'password': password,
      }),
    );
    Map<String, dynamic> body = json.decode(response.body);
    switch (body['code']['value']) {
      case 200:
        Cookie cookie =
            new Cookie.fromSetCookieValue(response.headers['set-cookie']);
        pref.setString('username', username);
        pref.setString('session', cookie.toString());
    }
    return body;
  }
}
