import 'dart:async';
import 'package:fl_uber/firebase/fire_base_auth.dart';
class AuthBloc {
  var fireAuth = FireAuth();
  StreamController _nameController = new StreamController();
  StreamController _phoneNumberController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get phoneNumberStream => _phoneNumberController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;

  bool isValid(String name, String email, String phone, String pass) {
    if(name == null || name.length == 0) {
      _nameController.sink.addError("Nhập tên");
      return false;
    }

    _nameController.sink.add("");

    if(phone == null || phone.length == 0) {
      _phoneNumberController.sink.addError("Nhập số điện thoại");
      return false;
    }

    _phoneNumberController.sink.add("");

    if(email == null || email.length == 0) {
      _emailController.sink.addError("Nhập email");
      return false;
    }

    _emailController.sink.add("");

    if(pass == null || pass.length < 6) {
      _passController.sink.addError("Mật khẩu phải có ít nhất 5 ký tự");
      return false;
    }

    _passController.sink.add("");
    return true;
  }
  void signUp(String email, String pass, String name, String phone, Function onSuccess, Function(String) onRegisterErr) {
    fireAuth.signUp(email, pass, name, phone, onSuccess, onRegisterErr);
  }

  void signIn(String email, String pass, Function onSuccess, Function(String) onRegisterErr) {
    fireAuth.signIn(email, pass, onSuccess, onRegisterErr);
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneNumberController.close();
  }
}