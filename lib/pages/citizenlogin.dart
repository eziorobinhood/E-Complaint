import 'package:ecomplaint/common/widgets/custom_button.dart';
import 'package:ecomplaint/common/widgets/custom_text.dart';
import 'package:ecomplaint/pages/signup.dart';
import 'package:ecomplaint/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CitizenLogin extends StatefulWidget {
  const CitizenLogin({super.key});

  @override
  State<CitizenLogin> createState() => _CitizenLoginState();
}

class _CitizenLoginState extends State<CitizenLogin> {
  final _signinuserkey = GlobalKey<FormState>();

  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  final AuthService authService = AuthService();

  void SigninUser() {
    authService.SigninUser(
        context: context, phoneNumber: phone.text, password: password.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: null,
          title: const Text("User Login"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Center(
            child: Form(
              key: _signinuserkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child:
                          Image.asset("assets/images/user_illustration.png")),
                  Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Text(
                        "User Login",
                        style: GoogleFonts.poppins(fontSize: 20),
                      )),
                  CustomTextField(
                      controller: phone,
                      hint: "Your phone number",
                      labeltext: "Phone Number"),
                  CustomTextField(
                      controller: password,
                      hint: "Your Password",
                      labeltext: "Password"),
                  CustomButton(
                      text: "Sign-In",
                      onTap: () {
                        if (_signinuserkey.currentState!.validate()) {
                          SigninUser();
                        }
                      }),
                  Container(
                    height: 80,
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * .20, 0, 0, 0),
                    child: Row(children: <Widget>[
                      const Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => const Signup())));
                          },
                          child: const Text("Create account"))
                    ]),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
