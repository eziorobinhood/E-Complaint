import 'package:ecomplaint/home.dart';
import 'package:ecomplaint/login.dart';
import 'package:ecomplaint/providers/userprovider.dart';
import 'package:ecomplaint/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_view/source/presentation/presentation.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.GetUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        debugShowCheckedModeBanner: false,
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? SplashView(
                backgroundColor: Colors.blue,
                loadingIndicator: const RefreshProgressIndicator(),
                logo: Image.asset("assets/images/logo.png"),
                done: Done(const Homepage()),
              )
            : const LoginOption());
  }
}
