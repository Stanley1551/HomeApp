abstract class Response {
  Response();
  int status;

  Response.fromJson(Map<String, dynamic> map);
}
