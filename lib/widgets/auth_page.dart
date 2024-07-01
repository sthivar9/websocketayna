import 'package:flutter/material.dart';
import 'package:websocketayna/screens/login_screen.dart';
import 'package:websocketayna/screens/register_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
      print('change');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(showRegisterPage: toggleScreen);
    } else {
      return RegisterScreen(showLoginPage: toggleScreen);
    }
  }
}
