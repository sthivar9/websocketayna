import 'dart:async';

mixin Validators {
  //email validator
  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (email.isEmpty) {
        return sink.addError("This field can't be empty");
      }
      if (email.length > 32) {
        return sink.addError("Email can't be more than 32 character");
      }
      if (email.length < 6) {
        return sink.addError("Email can't be less than 6 character");
      } else {
        sink.add(email);
      }
    },
  );

  var loginPasswordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.isEmpty) {
        return sink.addError("This field can't be empty");
      }
      if (password.length > 32) {
        return sink.addError("Password can't be more than 32 character");
      }
      if (password.length < 8) {
        return sink.addError("Password can't be less than 8 character");
      } else {
        sink.add(password);
      }
    },
  );

  var nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.isEmpty) {
        return sink.addError("This field can't be empty");
      }
      if (name.length > 32) {
        return sink.addError("name can't be more than 32 character");
      }
      if (name.length < 3) {
        return sink.addError("name can't be less than 3 character");
      } else {
        sink.add(name);
      }
    },
  );

  var phoneValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink) {
      if (phone.isEmpty) {
        return sink.addError("This field can't be empty");
      }
      if (phone.length > 10) {
        return sink.addError("Phone no can't be more than 10 character");
      }
      if (phone.length < 10) {
        return sink.addError("Phone no can't be less than 10 character");
      } else {
        sink.add(phone);
      }
    },
  );

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (pass, sink) {
      if (pass.isEmpty) {
        return sink.addError("This field can't be empty");
      }
      if (pass.length > 32) {
        return sink.addError("pass can't be more than 32 character");
      }
      if (pass.length < 8) {
        return sink.addError("pass can't be less than 8 character");
      } else {
        sink.add(pass);
      }
    },
  );
}
