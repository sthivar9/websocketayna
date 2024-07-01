import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocketayna/bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({required this.showRegisterPage, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          color: const Color.fromRGBO(151, 226, 231, 1),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Login Page",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                StreamBuilder<String>(
                    stream: bloc.loginEmail,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Enter Email",
                            labelText: "Email",
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: bloc.changeLoginEmail,
                      );
                    }),
                const SizedBox(height: 30),
                StreamBuilder<String>(
                    stream: bloc.loginPassword,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password",
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: bloc.changeLoginPassword,
                      );
                    }),
                const SizedBox(height: 30),
                _buildButton(),
                const SizedBox(height: 30),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Need an Account",
                      style: TextStyle(color: Colors.black)),
                  const WidgetSpan(
                      child: SizedBox(
                    width: 5,
                  )),
                  TextSpan(
                      text: "Register",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 27, 27, 27), fontSize: 18),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.showRegisterPage();
                          print('tap');
                        })
                ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    final bloc = Provider.of<LoginBloc>(context, listen: false);
    return StreamBuilder<Object>(
        stream: bloc.isValid,
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: snapshot.hasError || !snapshot.hasData
                ? null
                : () {
                    bloc.submit();
                  },
            child: Container(
              height: 35,
              width: 110,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: snapshot.hasError || !snapshot.hasData
                    ? Colors.grey
                    : const Color.fromARGB(255, 0, 166, 216),
              ),
              child: const Text(
                "Login",
                style: TextStyle(
                    color: Color.fromARGB(255, 112, 255, 207), fontSize: 23),
              ),
            ),
          );
        });
  }
}
