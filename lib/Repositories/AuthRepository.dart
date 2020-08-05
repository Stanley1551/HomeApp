import 'package:global_configuration/global_configuration.dart';
import 'package:homeapp/Repositories/Models/Contracts/RegisterResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'Models/Requests/Requests.dart';
import 'Models/Responses/Responses.dart';
import 'Models/Contracts/LoginResult.dart';
import 'dart:convert';

abstract class AAuthRepository {
  Future<Object> getAllUsers();
  Future<Object> getUsersByName(String name);
  Future<Object> getUserById(int id);
  Future<RegisterResult> register(String username, String password);
  Future<LoginResult> login(String username, String password);
  Future<String> retrieveToken();
  Future<void> saveToken(String token);
}

class AuthRepository extends AAuthRepository {
  String loginUrl;
  String registerUrl;
  AuthRepository() {
    final String url = GlobalConfiguration().getString('serviceUrl');
    final String loginPath = GlobalConfiguration().getString('loginPath');
    final String registerPath = GlobalConfiguration().getString('registerPath');

    if (url == null || loginPath == null || registerPath == null) {
      throw Exception('Unable to load mandatory configurations!');
    }

    loginUrl = url + loginPath;
    registerUrl = url + registerPath;
  }
  @override
  Future<Object> getAllUsers() {
    throw UnimplementedError();
  }

  @override
  Future<Object> getUserById(int id) {
    throw UnimplementedError();
  }

  @override
  Future<Object> getUsersByName(String name) {
    throw UnimplementedError();
  }

  @override
  Future<LoginResult> login(String username, String password) async {
    bool isSuccess = false;
    String message = '';
    AuthRequest requestBody = AuthRequest(username, password);
    http.Response result =
        await http.post(loginUrl, body: requestBody.toJson());

    var response = LoginResponse.fromJson(jsonDecode(result.body));

    if (result.statusCode == 200) {
      if (response.status == 1) {
        String token = response.data.token;
        await saveToken(token);

        isSuccess = true;
      }
    } else if (result.statusCode == 400) {
      if (response.status == 3) {
        message = 'Invalid username';
      } else if (response.status == 4) {
        message = 'Invalid password';
      }
    } else if (result.statusCode == 401) {
      message = 'Invalid password';
    } else {
      message = 'Unexpected Error';
    }

    return LoginResult(isSuccess, message: message);
  }

  @override
  Future<RegisterResult> register(String username, String password) async {
    bool isSuccess = false;
    String message = '';
    AuthRequest requestBody = AuthRequest(username, password);
    var result = await http.post(registerUrl, body: requestBody.toJson());
    var response = RegisterResponse.fromJson(jsonDecode(result.body));

    if (result != null && result.statusCode == 201) {
      if (response.status == 1) {
        isSuccess = true;
      }
    } else if (result.statusCode == 400) {
      if (response.status == 3) {
        message = 'Invalid username!';
      } else if (response.status == 4) {
        message = 'Invalid password!';
      }
    } else if (result.statusCode == 409) {
      message = 'Username already exists!';
    } else if (result.statusCode == 500) {
      message = 'User creation failed on server!';
    } else {
      message = 'Unexpected Error';
    }
    return RegisterResult(isSuccess, message: message);
  }

  @override
  Future<String> retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<bool> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    return await prefs.setString('token', token);
  }

  Future<bool> deleteToken() async {
    //TODO new state?
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
