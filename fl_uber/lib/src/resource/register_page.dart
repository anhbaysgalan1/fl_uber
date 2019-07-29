import 'package:fl_uber/blocs/auth_bloc.dart';
import 'package:fl_uber/src/resource/app.dart';
import 'package:fl_uber/src/resource/dialog/loading_dialog.dart';
import 'package:fl_uber/src/resource/dialog/msg_dialog.dart';
import 'package:fl_uber/src/resource/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneNumberController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    MyApp.of(context).authBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xff3277D8)),
        elevation: 0,
      ),
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
              Image.asset("ic_car_red.png"),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Text(
                  "Welcome Aboard!",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 11, 0, 0),
                child: Text(
                  "Signup with iCab in simple steps",
                  style: TextStyle(color: Color(0xff606470), fontSize: 16),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                child: StreamBuilder(
                    stream:  MyApp.of(context).authBloc.nameStream,
                    builder: (context, snapshot) => TextField(
                          controller: _nameController,
                          style: TextStyle(fontSize: 16, color: Colors.black),
                          decoration: InputDecoration(
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              labelText: "Name",
                              prefixIcon: Container(
                                width: 50,
                                child: Image.asset("ic_user.png"),
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xCED0D2), width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                  stream:  MyApp.of(context).authBloc.phoneNumberStream,
                    builder: (context, snapshot) => TextField(
                      controller: _phoneNumberController,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error : null,
                      labelText: "Phone Number",
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("ic_phone.png"),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                  stream:  MyApp.of(context).authBloc.emailStream,
                  builder: (context, snapshot) => TextField(
                    controller: _emailController,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error : null,
                      labelText: "Email",
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("ic_email.png"),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),
                )),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: StreamBuilder(
                  stream:  MyApp.of(context).authBloc.passStream,
                  builder: (context, snapshot) => TextField(
                    controller: _passController,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration(
                    errorText: snapshot.hasError ? snapshot.error : null,
                      labelText: "Passworld",
                      prefixIcon: Container(
                        width: 50,
                        child: Image.asset("ic_lock.png"),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Color(0xffCED0D2), width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(6)))),
                ),)),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 32, 0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: RaisedButton(
                    onPressed: () {
                      _onSignUpClicked();
                    },
                    child: Text(
                      "Signup",
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
                        text: "Already a User?",
                        style:
                            TextStyle(color: Color(0xff606470), fontSize: 16),
                        children: <TextSpan>[
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {

                            },
                          text: "Login now",
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

  _onSignUpClicked() {
    var _authBloc = MyApp.of(context).authBloc;
    var isValid = _authBloc.isValid(_nameController.text, _emailController.text,
        _phoneNumberController.text, _passController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, "Loading...");
      _authBloc.signUp(_emailController.text, _passController.text, _nameController.text, _phoneNumberController.text, () {
        LoadingDialog.hideLoadingDialog(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
      }, (error) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Sign-In", error);
      });
    }
  }
}
