import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:ecomplaint/constants/utils.dart';
import 'package:ecomplaint/models/problemmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../constants/error_handler.dart';

class Problems {
  String uri = "http://192.168.43.163:3000";

  void ProblemUploader(
      {required BuildContext context,
      required String problem,
      required String problemtype,
      required String problemlocation,
      required XFile image}) async {
    try {
      final cloudinary = CloudinaryPublic("ddvlaqley", "yxozwzar");
      CloudinaryResponse cloudinaryres = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image.path, folder: "Problems"));
      Problemstatement statement = Problemstatement(
        problem: problem,
        problemtype: problemtype,
        problemlocation: problemlocation,
        problemimage: cloudinaryres.secureUrl,
      );

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
