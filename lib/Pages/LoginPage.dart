import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/bloc/Authentication/authentication_bloc.dart';
import 'package:homeapp/bloc/Login/login_bloc.dart';
import '../CustomControls/LoginForm.dart';

class LoginPage extends StatelessWidget {
  final AAuthRepository repo;

  const LoginPage({Key key, this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<LoginBloc>(
      create: (context) {
        return LoginBloc(BlocProvider.of<AuthenticationBloc>(context), repo);
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  'Sign in',
                  style: TextStyle(
                      color: Colors.blue,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 50),
                ),
              ),
              LoginForm(),
            ],
          ),
        ),
      ),
    ));
  }
}
