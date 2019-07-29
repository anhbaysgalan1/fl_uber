import 'package:fl_uber/src/resource/app.dart';
import 'package:fl_uber/src/resource/login_page.dart';
import 'package:flutter/material.dart';
import 'blocs/auth_bloc.dart';

void main() => runApp(MyApp(
    new AuthBloc(),
    MaterialApp(
      home: LoginPage(),
    )));
