import 'Response.dart';

class PingResponse extends Response {
  String msg;

  PingResponse();

  PingResponse.fromJson(Map<String, dynamic> map) {
    status = map['status'];
    msg = map['msg'];
  }
}
