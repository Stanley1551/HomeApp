import 'package:global_configuration/global_configuration.dart';
import 'package:homeapp/Repositories/Models/Contracts/RegisterResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'AuthValidator.dart';
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
  Future<bool> deleteToken();
  AuthValidator validator;
  AAuthRepository();
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

    this.validator = AuthValidator((token) => saveToken(token));
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
    http.Response result;
    AuthRequest requestBody = AuthRequest(username, password);
    try {
      result = await http
          .post(loginUrl, body: requestBody.toJson())
          .timeout(Duration(seconds: 10));
    } catch (e) {
      return LoginResult(false,
          message: 'Unfortunately, server is not available.');
    }

    return validator.validateLogin(result);
  }

  @override
  Future<RegisterResult> register(String username, String password) async {
    http.Response result;
    AuthRequest requestBody = AuthRequest(username, password);
    try {
      result = await http
          .post(registerUrl, body: requestBody.toJson())
          .timeout(Duration(seconds: 10));
    } catch (e) {
      return RegisterResult(false,
          message: 'Unfortunately, server is not available.');
    }

    return validator.validateRegister(result);
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
    return await prefs.clear();
  }
}
