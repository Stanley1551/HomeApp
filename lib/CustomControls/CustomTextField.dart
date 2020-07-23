import 'package:flutter/material.dart';

class CustomLoginTextField extends StatelessWidget {
  final String placeholder;
  final TextEditingController controller;
  final bool isPasswordField;
  final bool isLogin;
  final double width;

  CustomLoginTextField(this.isLogin,
      {this.placeholder, this.controller, this.isPasswordField, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == null ? 200 : width,
      child: TextFormField(
        enabled: true,
        autocorrect: false,
        maxLines: 1,
        minLines: 1,
        cursorColor: Colors.cyan,
        style: TextStyle(),
        obscureText: isPasswordField == null ? false : isPasswordField,
        validator: (isPasswordField != null && isPasswordField)
            ? (value) => isLogin
                ? _passwordValidationForLogin(value)
                : _passwordValidationForRegister(value)
            : (value) => isLogin
                ? _usernameValidationForLogin(value)
                : _usernameValidationForRegister(value),
        //cursorRadius: Radius.elliptical(50, 100),
        enableSuggestions: false,
        //validator: ,
        strutStyle: StrutStyle(height: 1.5),
        controller: controller,
        decoration: InputDecoration(
            icon: (isPasswordField != null && isPasswordField)
                ? Icon(Icons.vpn_key)
                : Icon(Icons.person),
            hintText: placeholder,
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent)),
            disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.lightBlueAccent)),
            //border: UnderlineInputBorder(
            //borderSide: BorderSide(color: Colors.lightBlueAccent)),
            focusColor: Colors.white),
      ),
    );
  }

  String _usernameValidationForLogin(String value) {
    value = value.trim();
    if (value == null || value.length < 3) {
      return 'Invalid username';
    }

    return null;
  }

  String _passwordValidationForLogin(String value) {
    value = value.trim();
    if (value == null || value.length < 6) {
      return 'Invalid password';
    }
    return null;
  }

  String _usernameValidationForRegister(String value) {
    value = value.trim();

    Pattern pattern = r'^(?!=.*?[0-9])(?!=.*?[!@#\$&*~]).{8,}$';
    RegExp regex = new RegExp(pattern);

    if (value == null || value.length < 3) {
      return 'Username must be at least 3 characters long';
    }

    if (regex.hasMatch(value)) {
      return 'Invalid username.';
    }

    return null;
  }

  String _passwordValidationForRegister(String value) {
    value = value.trim();
    Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])$';
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty || value.length < 6) {
      return 'Password must be at least 6 characters long.';
    } else {
      if (!regex.hasMatch(value))
        return 'Password is invalid.';
      else
        return null;
    }
  }
}
