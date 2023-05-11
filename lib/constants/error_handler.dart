import 'dart:convert';

import 'package:ecomplaint/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

void errorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(context, jsonDecode(response.body())['msg']);
      break;
    case 500:
      showSnackbar(context, jsonDecode(response.body())['error']);
      break;
    default:
      showSnackbar(context, response.body());
  }
}
