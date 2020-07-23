import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/bloc/Register/register_bloc.dart';

import 'CustomTextField.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm();

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();
  final TextEditingController passwordFieldAgainController =
      TextEditingController();

  _RegisterFormState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return Form(
        //manual validation!!!
        autovalidate: false,
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 45),
                child: Column(
                  children: <Widget>[
                    CustomLoginTextField(
                      false,
                      placeholder: 'Username',
                      width: 270,
                      controller: usernameFieldController,
                    ),
                    CustomLoginTextField(
                      false,
                      placeholder: 'Password',
                      width: 270,
                      isPasswordField: true,
                      controller: passwordFieldController,
                    ),
                    CustomLoginTextField(
                      false,
                      placeholder: 'Password again',
                      width: 270,
                      isPasswordField: true,
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Divider(
                    color: Colors.black,
                  )),
              MaterialButton(
                  onPressed: () => _handleRegisterButtonPushed,
                  child: Text('Register'),
                  minWidth: 240,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(color: Colors.white))),
            ]),
      );
    });
  }

  _handleRegisterButtonPushed() {
    bool validateResult = _formKey.currentState.validate();

    if(validateResult){
      BlocProvider.of<RegisterBloc>(context).add(RegisterButtonPressed(
        usernameFieldController.text, passwordFieldAgainController.text));
    }
  }
}