import 'Response.dart';

class RegisterResponse extends Response {
  RegisterData data;
  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = RegisterData(json['id']);
  }
}

class RegisterData {
  int id;

  RegisterData(this.id);
}
