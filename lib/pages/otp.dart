import 'package:ecomplaint/home.dart';
import 'package:ecomplaint/pages/citizenlogin.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class OTPVerifcation extends StatefulWidget {
  const OTPVerifcation({super.key});

  @override
  State<OTPVerifcation> createState() => _OTPVerifcationState();
}

class _OTPVerifcationState extends State<OTPVerifcation> {
  OtpFieldController otpController = OtpFieldController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OTPTextField(
                controller: otpController,
                length: 5,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 45,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                }),
            Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.5,
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), minimumSize: Size.fromHeight(60)),
                child: Text("Verify OTP"),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
