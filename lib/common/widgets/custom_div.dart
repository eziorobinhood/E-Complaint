// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDiv extends StatelessWidget {
  String data;
  CustomDiv({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
      child: Text(
        data,
        style: GoogleFonts.poppins(fontSize: 15),
      ),
    );
  }
}
