import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Models/Contracts/LoginResult.dart';
import 'Models/Contracts/RegisterResult.dart';
import 'Models/Responses/Responses.dart';

class AuthValidator {
  final Function(String) saveTokenCallback;
  AuthValidator(this.saveTokenCallback);

  LoginResult validateLogin(http.Response result) {
    bool isSuccess = false;
    String message = '';
    var response = LoginResponse.fromJson(jsonDecode(result.body));

    if (result.statusCode == 200) {
      if (response.status == 1) {
        String token = response.data.token;
        saveTokenCallback(token);

        isSuccess = true;
      }
    } else if (result.statusCode == 400) {
      if (response.status == 3) {
        message = 'Invalid username';
      } else if (response.status == 4) {
        message = 'Invalid password';
      }
    } else if (result.statusCode == 401) {
      message = 'Invalid password';
    } else {
      message = 'Unexpected Error';
    }

    return LoginResult(isSuccess, message: message);
  }

  RegisterResult validateRegister(http.Response result) {
    bool isSuccess = false;
    String message = '';
    var response = RegisterResponse.fromJson(jsonDecode(result.body));

    if (result != null && result.statusCode == 201) {
      if (response.status == 1) {
        isSuccess = true;
      }
    } else if (result.statusCode == 400) {
      if (response.status == 3) {
        message = 'Invalid username!';
      } else if (response.status == 4) {
        message = 'Invalid password!';
      }
    } else if (result.statusCode == 409) {
      message = 'Username already exists!';
    } else if (result.statusCode == 500) {
      message = 'User creation failed on server!';
    } else {
      message = 'Unexpected Error';
    }
    return RegisterResult(isSuccess, message: message);
  }
}
