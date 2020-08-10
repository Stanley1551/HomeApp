import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/bloc/Register/register_bloc.dart';
import '../CustomControls/RegisterForm.dart';

class RegisterPage extends StatelessWidget {
  final AAuthRepository repo;

  RegisterPage(this.repo) : assert(repo != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<RegisterBloc>(
      create: (context) {
        return RegisterBloc(repo);
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
                  'Register',
                  style: TextStyle(
                      color: Colors.blue,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 50),
                ),
              ),
              RegisterForm(),
            ],
          ),
        ),
      ),
    ));
  }
}
