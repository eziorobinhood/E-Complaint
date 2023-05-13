// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecomplaint/constants/error_handler.dart';
import 'package:ecomplaint/constants/utils.dart';
import 'package:ecomplaint/pages/list.dart';
import 'package:ecomplaint/providers/userprovider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AuthService {
  String uri = "http://192.168.43.163:3000";
  void SigninAdmin({
    required BuildContext context,
    required String username,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/admin/signin'),
        body: jsonEncode({"username": username, "password": password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      errorHandler(
          response: res,
          context: context,
          onSuccess: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.setString(
                'x-auth-admin-token', jsonDecode(res.body)['token']);

            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const ListProblems()));
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void GetAdminData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-admin-token');
      if (token == null) {
        prefs.setString('x-auth-admin-token', '');
      }

      var tokenres = await http.post(Uri.parse('$uri/ValidateToken'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token!
          });

      var response = jsonDecode(tokenres.body);
      if (response == true) {
        http.Response userResponse = await http.get(Uri.parse('$uri/'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': token
            });
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
