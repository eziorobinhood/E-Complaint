// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:ecomplaint/constants/error_handler.dart';
import 'package:ecomplaint/constants/utils.dart';
import 'package:ecomplaint/home.dart';
import 'package:ecomplaint/providers/userprovider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String uri = "http://192.168.43.163:3000";

  //   -------------------
  //  |   SIGN UP USER    |
  //   -------------------

  void SignupUser(
      {required BuildContext context,
      required String name,
      required String phoneNumber,
      required String password,
      required String confirmPassword}) async {
    try {
      User user = User(
          id: "",
          name: name,
          phoneNumber: phoneNumber,
          password: password,
          confirmPassword: confirmPassword,
          type: "",
          token: "");

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      errorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context,
                'Account has been created! Login with the same credentials');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void SigninUser({
    required BuildContext context,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({"phoneNumber": phoneNumber, "password": password}),
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
                'x-auth-token', jsonDecode(res.body)['token']);

            Provider.of<UserProvider>(context, listen: false).setUser(res.body);

            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const Homepage()));
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void GetUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
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
