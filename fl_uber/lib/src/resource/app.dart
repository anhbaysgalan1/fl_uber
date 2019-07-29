import 'package:fl_uber/blocs/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends InheritedWidget {
  // This widget is the root of your application.
  final AuthBloc authBloc;
  final Widget child;
  MyApp(this.authBloc, this.child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return false;
  }

  static MyApp of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(MyApp);
  }
}