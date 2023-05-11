import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
      color: Colors.customBlue,
      child: Center(
        child: Column(
          children: [
            Image.asset("assets/images/logo.png"),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.customDarkGrey,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Please wait...",
              style: GoogleFonts.pacifico(fontSize: 25, color: Colors.white),
            )
          ],
        ),
      ),
    ));
  }
}
