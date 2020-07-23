import 'Request.dart';

//Basically Login and Register has the same requestbody yet.
class AuthRequest extends Request {
  String username;
  String password;

  AuthRequest(this.username, this.password);

  @override
  Map<String, dynamic> toJson() => {'username': username, 'password': password};
}
