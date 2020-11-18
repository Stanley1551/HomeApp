import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:homeapp/Repositories/Models/Contracts/RegisterResult.dart';
import 'package:homeapp/Repositories/Models/Contracts/UsersResult.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'AuthValidator.dart';
import 'Models/Requests/Requests.dart';
import 'Models/Contracts/LoginResult.dart';

abstract class AAuthRepository {
  Future<Object> getAllUsers();
  Future<Object> getUsersByName(String name);
  Future<Object> getUserById(int id);
  Future<RegisterResult> register(String username, String password);
  Future<LoginResult> login(String username, String password);
  Future<String> retrieveToken();
  Future<void> saveToken(String token);
  Future<bool> deleteToken();
  Future<String> getAuthenticatedUsername();
  Future<int> getAuthenticatedUserID();
  Future<bool> saveUserID(int id);
  Future<String> retrieveUserNameByID(int id);
  AuthValidator validator;
  AAuthRepository();
}

class AuthRepository extends AAuthRepository {
  String loginUrl;
  String registerUrl;
  String usersUrl;
  Map<int,String> useridToName;

  AuthRepository() {
    final String url = GlobalConfiguration().getString('serviceUrl');
    final String loginPath = GlobalConfiguration().getString('loginPath');
    final String registerPath = GlobalConfiguration().getString('registerPath');
    final String usersPath = GlobalConfiguration().getString('usersPath');

    if (url == null || loginPath == null || registerPath == null) {
      throw Exception('Unable to load mandatory configurations!');
    }

    loginUrl = url + loginPath;
    registerUrl = url + registerPath;
    usersUrl = url + usersPath;

    this.validator =
        AuthValidator((token) => saveToken(token), (id) => saveUserID(id));
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
    } on TimeoutException catch (e) {
      return LoginResult(false,
          message: 'Unfortunately, server is not responding.');
    } on SocketException catch (e) {
      return LoginResult(false,
          message:
              e.message + ', ' + e.address.address + ', ' + e.osError.message);
    } catch (e) {
      return LoginResult(false,
          message: '(' +
              e.runtimeType.toString() +
              ') Unfortunately, server is not reachable.');
    }
    //TODO??
    await saveUserName(username);

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
    } on TimeoutException catch (e) {
      return RegisterResult(false,
          message: 'Unfortunately, server is not responding.');
    } on Exception catch (e) {
      return RegisterResult(false,
          message: 'Unfortunately, server is not reachable.');
    }
    //TODO?
    await saveUserName(username);

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
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  ///Loads the authenticated user's name.
  ///Upon error, or if none authenticated, returns an empty string.
  Future<String> getAuthenticatedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString('username');
    } catch (e) {
      return '';
    }
  }

  Future<bool> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString('username', name);
  }

  Future<int> getAuthenticatedUserID() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getInt('userid');
    } catch (e) {
      return 0;
    }
  }

  Future<bool> saveUserID(int id) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setInt('userid', id);
  }

  @override
  Future<String> retrieveUserNameByID(int id)async {
    if(useridToName == null){
      useridToName = new Map<int,String>();
      try
      {
        var response = await http.get(usersUrl);
        if(response.statusCode == 200)
        {
          var result = UsersResult.fromJson(jsonDecode(response.body));

          result.data.forEach((element) => useridToName[element.id] = element.username);
        }
      }catch(e){print(e);}
      
    }
    if(useridToName.containsKey(id)){
      return useridToName[id];
    }
    else
    {
      //TODO: logic for single user
      return null;
    }
    
  }
}
