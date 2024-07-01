import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:websocketayna/bloc/validators.dart';

class LoginBloc with Validators {
  final _loginEmail = BehaviorSubject<String>();
  final _loginPassword = BehaviorSubject<String>();

  //getter

  Stream<String> get loginEmail => _loginEmail.stream.transform(emailValidator);
  Stream<String> get loginPassword =>
      _loginPassword.stream.transform(loginPasswordValidator);

  Stream<bool> get isValid =>
      Rx.combineLatest2(loginEmail, loginPassword, (a, b) => true);

  //setter
  Function(String) get changeLoginEmail => _loginEmail.sink.add;
  Function(String) get changeLoginPassword => _loginPassword.sink.add;

  void submit() {
    print(_loginEmail.value);
    print(_loginPassword.value);
    signIn();
  }

  //transformers

  void dispose() {
    _loginEmail.close();
    _loginPassword.close();
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmail.value, password: _loginPassword.value);
  }

  void setState(Null Function() param0) {}
}
