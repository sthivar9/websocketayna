import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:websocketayna/screens/home_screen.dart';
import 'package:websocketayna/widgets/auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return AuthPage();
            }
          }),
    );
  }
}
