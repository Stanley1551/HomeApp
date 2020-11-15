import 'package:homeapp/Repositories/Models/Responses/Responses.dart';

import 'Result.dart';

class LoginResult extends Result {
  String message;
  LoginResponse response;

  LoginResult(bool isSuccess, {this.message, this.response}) {
    this.isSuccess = isSuccess;
  }
}
