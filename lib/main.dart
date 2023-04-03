import 'package:ecomplaint/login.dart';
import 'package:flutter/material.dart';
import 'package:splash_view/source/presentation/presentation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.customBlue),
        debugShowCheckedModeBanner: false,
        home: SplashView(
          backgroundColor: Colors.grey,
          loadingIndicator: const RefreshProgressIndicator(),
          logo: Image.asset("assets/images/logo.png"),
          done: Done(const LoginOption()),
        ));
  }
}
