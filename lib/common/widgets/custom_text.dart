import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String labeltext;
  final int maxLines;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    required this.labeltext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 4,
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        obscureText: controller.text == 'password' ? true : false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(90.0),
          ),
          labelText: labeltext,
        ),
        validator: (val) {
          if (val == null || val.isEmpty) {
            return hint;
          }
          return null;
        },
      ),
    );
  }
}
