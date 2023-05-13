import 'package:ecomplaint/pages/adminlogin.dart';
import 'package:ecomplaint/pages/citizenlogin.dart';
import "package:flutter/material.dart";
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginOption extends StatefulWidget {
  const LoginOption({super.key});

  @override
  State<LoginOption> createState() => _LoginOptionState();
}

class _LoginOptionState extends State<LoginOption> {
  int _selectedIndex = 0;
  final List<Widget> _children = [const AdminLogin(), const CitizenLogin()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.userGear), label: "Admin Login"),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.usersRays), label: 'User Login'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
