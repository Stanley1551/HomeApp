import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeapp/CustomControls/CustomCircularProgressDialog.dart';
import 'package:homeapp/CustomControls/CustomDialog.dart';
import 'package:homeapp/bloc/Login/login_bloc.dart';

import 'CustomTextField.dart';

class LoginForm extends StatefulWidget {
  LoginForm();

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  _LoginFormState();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (BuildContext context, LoginState state) {
        if (state is SwitchToRegister) {
          Navigator.pushNamed(context, '/register');
        } else if (state is LoginFailed) {
          showDialog(
              context: context,
              builder: (context) => CustomDialog(state.message, Icons.cancel));
        }
        /*else if (state is LoginInProgress) {
          showDialog(
              context: context,
              builder: (context) => CustomCircularProgressDialog());
        }*/
      },
      child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
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
                        true,
                        placeholder: 'Username',
                        width: 270,
                        controller: usernameFieldController,
                      ),
                      CustomLoginTextField(
                        true,
                        placeholder: 'Password',
                        width: 270,
                        isPasswordField: true,
                        controller: passwordFieldController,
                      ),
                      Divider(
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: MaterialButton(
                        onPressed: () {
                          if (state is LoginInProgress) {
                            //just ignore the user spamming
                            return;
                          }
                          bool validateResult =
                              _formKey.currentState.validate();

                          if (validateResult) {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonPressed(usernameFieldController.text,
                                    passwordFieldController.text));
                          }
                        },
                        splashColor: Colors.blueAccent,
                        color: Colors.blue,
                        child: Text('Login'),
                        minWidth: 240,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide.none))),
                state is LoginInProgress
                    ? CircularProgressIndicator()
                    : MaterialButton(
                        onPressed: () => BlocProvider.of<LoginBloc>(context)
                            .add(RegisterButtonPressed()),
                        child: Text('Register'),
                        minWidth: 240,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.white))),
              ]),
        );
      }),
    );
  }
}
