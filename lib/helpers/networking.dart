import 'package:chat/components/my_alert_dialog.dart';
import 'package:chat/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NetworHelper {
  NetworHelper({this.url, this.context, this.body});
  final url;
  final context;
  final body;

  Future postData() async {
    dynamic headers = await getHeaders();
    http.Response response =
        await http.post(Uri.parse(kServer + url), body: body, headers: headers);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      String data = response.body;
      String dataJson = '';
      jsonDecode(data).forEach((k, v) => dataJson = '$dataJson $v \n');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog('Error', Text(dataJson));
        },
      );
    }
  }

  Future getData() async {
    dynamic headers = await getHeaders();
    http.Response response =
        await http.get(Uri.parse(kServer + url), headers: headers);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      String data = response.body;
      String dataJson = '';
      jsonDecode(data).forEach((k, v) => dataJson = '$dataJson $v \n');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MyAlertDialog('Error', Text(dataJson));
        },
      );
    }
  }

  getHeaders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic token = prefs.getString('token');
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      // 'Content-Type': 'application/json',
    };

    return headers;
  }
}
