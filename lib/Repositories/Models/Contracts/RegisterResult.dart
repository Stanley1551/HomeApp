import 'Result.dart';

class RegisterResult extends Result {
  String message;

  RegisterResult(bool isSuccess, {this.message}) {
    this.isSuccess = isSuccess;
  }
}
