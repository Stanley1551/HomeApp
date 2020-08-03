import 'Result.dart';

class LoginResult extends Result {
  String message;

  LoginResult(bool isSuccess, {this.message}) {
    this.isSuccess = isSuccess;
  }
}
