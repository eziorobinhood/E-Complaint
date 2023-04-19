import 'package:ecomplaint/constants/utils.dart';
import 'package:ecomplaint/models/problemmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constants/error_handler.dart';

class Problems {
  String uri = "http://192.168.182.201:3000";

  void ProblemUploader({
    required BuildContext context,
    required String problem,
  }) async {
    try {
      Problemstatement statement = Problemstatement(problem: problem);

      http.Response res = await http.post(
        Uri.parse('$uri/api/problemupload'),
        body: statement.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      errorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(context, 'Problem Submitted');
          });
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
