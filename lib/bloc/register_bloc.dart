import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:websocketayna/bloc/validators.dart';

class RegisterBloc with Validators {
  final _name = BehaviorSubject<String>();
  final _email = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _confirmPassword = BehaviorSubject<String>();

  //getter
  Stream<String> get name => _name.stream.transform(nameValidator);
  Stream<String> get email => _email.stream.transform(emailValidator);
  Stream<String> get phone => _phoneNumber.stream.transform(phoneValidator);
  Stream<String> get password => _password.stream.transform(passwordValidator);
  Stream<String> get confirmPass =>
      _confirmPassword.stream.transform(passwordValidator);

  Stream<bool> get isValid => Rx.combineLatest5(
      name, email, phone, password, confirmPass, (a, b, c, v, e) => true);

  Stream<bool> get isPassword =>
      Rx.combineLatest2(password, confirmPass, (a, b) {
        if (a != b) {
          return false;
        } else {
          return true;
        }
      });

  //setter

  Function(String) get changeName => _name.sink.add;
  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changephone => _phoneNumber.sink.add;
  Function(String) get changePass => _password.sink.add;
  Function(String) get changeConfirmPass => _confirmPassword.sink.add;

  void submit() {
    if (_password != _confirmPassword) {
      print("wrong pass");
      print(_password.value);
      print(_confirmPassword.value);
      signUp();
    } else {
      print(_name.value);
      print(_email.value);
      print(_phoneNumber.value);
      print(_password.value);
      print(_confirmPassword.value);
      signUp();
    }
  }

  void dispose() {
    _name.close();
    _email.close();
    _phoneNumber.close();
    _password.close();
    _confirmPassword.close();
  }

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _email.value,
      password: _password.value,
    );
  }
}
