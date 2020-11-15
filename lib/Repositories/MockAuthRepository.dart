import 'package:homeapp/Repositories/AuthRepository.dart';
import 'package:homeapp/Repositories/Models/Contracts/RegisterResult.dart';
import 'package:homeapp/Repositories/Models/Contracts/LoginResult.dart';

class MockAuthRepository extends AAuthRepository {
  String mockToken;

  MockAuthRepository({this.mockToken});

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
    return await Future.delayed(Duration(seconds: 1))
        .then((value) => LoginResult(true));
  }

  @override
  Future<RegisterResult> register(String username, String password) async {
    return await Future.delayed(Duration(seconds: 1))
        .then((value) => RegisterResult(true));
  }

  @override
  Future<String> retrieveToken() async {
    return mockToken;
  }

  @override
  Future<bool> saveToken(String token) async {
    mockToken = token;
    return true;
  }

  Future<bool> deleteToken() async {
    mockToken = '';
    return true;
  }

  @override
  Future<String> getAuthenticatedUsername() async {
    return await Future.delayed(Duration(seconds: 1))
        .then((value) => 'MockUser');
  }

  @override
  Future<int> getAuthenticatedUserID() {
    // TODO: implement getAuthenticatedUserID
    throw UnimplementedError();
  }

  @override
  Future<bool> saveUserID(int id) {
    // TODO: implement saveUserID
    throw UnimplementedError();
  }
}
