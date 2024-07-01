import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:websocketayna/bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterScreen({required this.showLoginPage, super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool isvisible = true;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<RegisterBloc>(context, listen: false);

    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          color: Color.fromRGBO(151, 226, 231, 1),
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                StreamBuilder<Object>(
                    stream: null,
                    builder: (context, snapshot) {
                      return StreamBuilder<Object>(
                          stream: bloc.name,
                          builder: (context, snapshot) {
                            return TextField(
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  hintText: "Enter Name",
                                  labelText: "Name",
                                  errorText: snapshot.hasError
                                      ? snapshot.error.toString()
                                      : null,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onChanged: bloc.changeName,
                            );
                          });
                    }),
                const SizedBox(height: 30),
                StreamBuilder<String>(
                    stream: bloc.email,
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
                        onChanged: bloc.changeEmail,
                      );
                    }),
                const SizedBox(height: 30),
                StreamBuilder<String>(
                    stream: bloc.phone,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: "Enter Phone no",
                            labelText: "Phone no",
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: bloc.changephone,
                      );
                    }),
                const SizedBox(height: 30),
                StreamBuilder<String>(
                    stream: bloc.password,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "Password",
                            labelText: "Password",
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onChanged: bloc.changePass,
                      );
                    }),
                const SizedBox(height: 30),
                StreamBuilder<String>(
                    stream: bloc.confirmPass,
                    builder: (context, snapshot) {
                      return TextField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: isvisible,
                        decoration: InputDecoration(
                            hintText: "Confirm Password",
                            labelText: "confirm Password",
                            errorText: snapshot.hasError
                                ? snapshot.error.toString()
                                : null,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            suffixIcon: IconButton(
                              icon: isvisible
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isvisible = !isvisible;
                                });
                              },
                            )),
                        onChanged: bloc.changeConfirmPass,
                      );
                    }),
                const SizedBox(height: 30),
                _buildButton(),
                const SizedBox(height: 30),
                RichText(
                    text: TextSpan(children: [
                  const TextSpan(
                      text: "Already have an Account",
                      style: TextStyle(color: Colors.black)),
                  const WidgetSpan(
                      child: SizedBox(
                    width: 5,
                  )),
                  TextSpan(
                      text: "Login here",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 27, 27, 27), fontSize: 18),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          widget.showLoginPage();
                          print("tap");
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
    final bloc = Provider.of<RegisterBloc>(context, listen: false);
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
                    : Color.fromARGB(255, 0, 166, 216),
              ),
              child: Text(
                "Register",
                style: TextStyle(
                    color: Color.fromARGB(255, 112, 255, 207), fontSize: 23),
              ),
            ),
          );
        });
  }
}
