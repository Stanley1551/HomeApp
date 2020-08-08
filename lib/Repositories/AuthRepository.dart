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
  Future<void> _saveToken(String token);

  AAuthRepository();
}

class AuthRepository extends AAuthRepository {
  String loginUrl;
  String registerUrl;
  AuthValidator validator;

  AuthRepository() {
    final String url = GlobalConfiguration().getString('serviceUrl');
    final String loginPath = GlobalConfiguration().getString('loginPath');
    final String registerPath = GlobalConfiguration().getString('registerPath');

    if (url == null || loginPath == null || registerPath == null) {
      throw Exception('Unable to load mandatory configurations!');
    }

    loginUrl = url + loginPath;
    registerUrl = url + registerPath;

    this.validator = AuthValidator((token) => _saveToken(token));
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
    AuthRequest requestBody = AuthRequest(username, password);
    http.Response result =
        await http.post(loginUrl, body: requestBody.toJson());

    return validator.validateLogin(result);
  }

  @override
  Future<RegisterResult> register(String username, String password) async {
    AuthRequest requestBody = AuthRequest(username, password);
    var result = await http.post(registerUrl, body: requestBody.toJson());

    return validator.validateRegister(result);
  }

  @override
  Future<String> retrieveToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  @override
  Future<bool> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    return await prefs.setString('token', token);
  }

  Future<bool> deleteToken() async {
    //TODO new state?
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
