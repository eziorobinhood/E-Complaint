import 'package:ecomplaint/common/widgets/custom_button.dart';
import 'package:ecomplaint/common/widgets/custom_text.dart';
import 'package:ecomplaint/pages/citizenlogin.dart';
import 'package:ecomplaint/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? _selectedOption;
  final _signupformkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final AuthService authService = AuthService();

  List<String> _options = [
    'Select your city',
    'Ariyalur',
    'Chennai',
    'Chengalpattu',
    'Coimbatore',
    'Cuddalore',
    'Dharmapuri',
    'Dindigul',
    'Erode',
    'Kallakurichi',
    'Kancheepuram',
    'Karur',
    'Krishnagiri',
    'Madurai',
    'Mayiladuthurai',
    'Nagapattinam',
    'Kanniyakumari',
    'Namakkal',
    'Perambalur',
    'Pudukottai',
    'Ramanathapuram',
    'Ranipet',
    'Salem',
    'Sivagangai',
    'Tenkasi',
    'Tanjavur',
    'Theni',
    'Thiruvallur',
    'Thiruvarur',
    'Thoothukudi',
    'Trichirapalli',
    'Thirunelveli',
    'Tirupathur',
    'Tiruppur',
    'Tiruvannamalai',
    'The Nilgris',
    'Vellore',
    'Viluppuram',
    'Virudhunagar'
  ];

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    phoneNumber.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  void signupUser() {
    authService.SignupUser(
        context: context,
        name: name.text,
        phoneNumber: phoneNumber.text,
        password: password.text,
        confirmPassword: confirmPassword.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Signup"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Image.asset(
                      "assets/images/user_signup_illustration.png")),
              Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    "User Signup",
                    style: GoogleFonts.poppins(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                color: Colors.white70,
                child: Form(
                  key: _signupformkey,
                  child: Column(
                    children: [
                      CustomTextField(
                          controller: name,
                          hint: "Enter your Name",
                          labeltext: "Your Name"),
                      CustomTextField(
                          controller: phoneNumber,
                          hint: "Enter your Phone Number",
                          labeltext: "Phone Number"),
                      CustomTextField(
                          controller: password,
                          hint: "Enter your Password",
                          labeltext: "Password"),
                      CustomTextField(
                          controller: confirmPassword,
                          hint: "Confirm your Password",
                          labeltext: "Confirm Password"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(90.0),
                          )),
                          value: _selectedOption,
                          items: _options.map((String option) {
                            return DropdownMenuItem(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedOption = newValue;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                          text: "Create Account",
                          onTap: () {
                            if (_signupformkey.currentState!.validate()) {
                              signupUser();
                            }
                          })
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(
                    MediaQuery.of(context).size.width * .20, 0, 0, 0),
                child: Row(children: <Widget>[
                  Text("Already having an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => CitizenLogin())));
                      },
                      child: Text("Sign-In"))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
