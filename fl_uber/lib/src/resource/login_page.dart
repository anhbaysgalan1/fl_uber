import 'package:fl_uber/firebase/fire_base_auth.dart';
import 'package:fl_uber/src/resource/app.dart';
import 'package:fl_uber/src/resource/dialog/loading_dialog.dart';
import 'package:fl_uber/src/resource/dialog/msg_dialog.dart';
import 'package:fl_uber/src/resource/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 140,
              ),
              Image.asset("assets/ic_car_green.png"),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  "Welcome Back!",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Text(
                  "Login to continue using iCab",
                  style: TextStyle(color: Color(0xff606470), fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 20),
                child: TextField(
                  controller: emailController,
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("assets/ic_email.png"),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
              ),
              TextField(
                controller: passController,
                style: TextStyle(fontSize: 18, color: Colors.black),
                decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Container(
                      width: 50,
                      child: Image.asset("assets/ic_lock.png"),
                    ),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xffCED0D2), width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(6)))),
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(color: Color(0xff606470), fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: () {
                      signIn();
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color(0xff3277D8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                child: RichText(
                    text: TextSpan(
                        text: "New User?",
                        style:
                            TextStyle(color: Color(0xff606470), fontSize: 16),
                        children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                          text: "Sign up for a new account",
                          style:
                              TextStyle(color: Color(0xff3277D8), fontSize: 16))
                    ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  void signIn() {
    var authBloc = MyApp.of(context).authBloc;
    LoadingDialog.showLoadingDialog(context, "Sign-In...");
    authBloc.signIn(emailController.text, passController.text, () {
      LoadingDialog.hideLoadingDialog(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }, (error) {
      LoadingDialog.hideLoadingDialog(context);
      MsgDialog.showMsgDialog(context, "Sign-In", error);
    });
  }
}
