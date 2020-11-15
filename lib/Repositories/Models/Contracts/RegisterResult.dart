import 'package:homeapp/Repositories/Models/Responses/Responses.dart';

import 'Result.dart';

class RegisterResult extends Result {
  String message;
  RegisterResponse response;

  RegisterResult(bool isSuccess, {this.message, this.response}) {
    this.isSuccess = isSuccess;
  }
}
