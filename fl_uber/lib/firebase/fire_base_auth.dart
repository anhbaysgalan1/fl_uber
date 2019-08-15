import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FireAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess, Function(String) onRegisterErr) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      print("signUp: $user");
      createUser(user.user.uid, name, phone, onSuccess, onRegisterErr);
    }).catchError((error) {
      _onSignUpErr(error.code, onRegisterErr);
    });
  }

  void signIn(String email, String pass, Function onSuccess, Function(String) onSignInErr) {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
          onSuccess();
    }).catchError((error) {
      onSignInErr("Sign-In fail, please try again");
    });
  }

  void createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegisterErr) {
    var user = {"name": name, "phone": phone};
    var ref = FirebaseDatabase.instance.reference().child("users");
    ref.child(userId).set(user).then((user) {
      onSuccess();
    }).catchError((error) {
      _onSignUpErr("", onRegisterErr);
    });
  }

  void _onSignUpErr(String code, Function(String) onRegisterErr) {
    switch (code) {
      case "ERROR_INVALID_EMAIL":
      case "ERROR_INVALID_CREDENTIAL":
        onRegisterErr("Invalid email");
        break;
      case "ERROR_EMAIL_ALREADY_IN_USE":
        onRegisterErr("Email has existed");
        break;
      case "ERROR_WEAK_PASSWORD":
        onRegisterErr("The password is not strong enough");
        break;
      default:
        onRegisterErr("Signup fail, please try again");
        break;
    }
  }
}
