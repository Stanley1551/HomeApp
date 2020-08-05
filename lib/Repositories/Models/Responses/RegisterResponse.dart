import 'Response.dart';

class RegisterResponse extends Response {
  RegisterData data;
  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = RegisterData(json['id']);
    }
  }
}

class RegisterData {
  int id;

  RegisterData(this.id);
}
