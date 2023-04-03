import 'package:ecomplaint/home.dart';
import 'package:ecomplaint/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CitizenLogin extends StatefulWidget {
  const CitizenLogin({super.key});

  @override
  State<CitizenLogin> createState() => _CitizenLoginState();
}

class _CitizenLoginState extends State<CitizenLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Login"),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Image.asset("assets/images/user_illustration.png")),
                Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(
                      "User Login",
                      style: TextStyle(fontSize: 30),
                    )),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Username/ Phone Number',
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width * .50,
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        minimumSize: const Size.fromHeight(40),
                      ),
                      child: const Text('Log In'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => Homepage())));
                      },
                    )),
                Container(
                  height: 80,
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.width * .20, 0, 0, 0),
                  child: Row(children: <Widget>[
                    Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => Signup())));
                        },
                        child: Text("Create account"))
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
