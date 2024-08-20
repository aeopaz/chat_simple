import 'package:chat/helpers/networking.dart';
import 'package:chat/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class User {
  Future<dynamic> getToken({context, email, password}) async {
    Map<String, String> body = {'email': email, 'password': password};
    NetworHelper networHelper =
        NetworHelper(url: '/login', context: context, body: body);

    var decodeData = await networHelper.postData();

    return decodeData;
  }

  Future<dynamic> register(
      {context, name, email, password, passwordConfirmation}) async {
    Map<String, String> body = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
    };

    NetworHelper networHelper =
        NetworHelper(url: '/register', context: context, body: body);

    var decodeData = await (networHelper.postData());
    return decodeData;
  }

  Future<dynamic> getUserData({context}) async {
    NetworHelper networHelper =
        NetworHelper(url: '/getUserData', context: context);

    var decodeData = await networHelper.getData();
    return decodeData;
  }

  logout(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushReplacementNamed(context, LoginPage.id);
  }
}
