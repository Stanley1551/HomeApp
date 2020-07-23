import 'Response.dart';

class LoginResponse extends Response {
  LoginData data;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = LoginData(
        json['data']['id'], json['data']['allowed'], json['data']['token']);
  }
}

class LoginData {
  int id;
  bool allowed;
  String token;

  LoginData(this.id, this.allowed, this.token);
}
