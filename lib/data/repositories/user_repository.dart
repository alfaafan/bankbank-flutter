import 'dart:convert';
import 'package:bankbank/data/datasources/remote/users_remote_datasource.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/entities/user_login.dart';

class UserRepository {
  final UsersRemoteDatasource remoteDatasource = UsersRemoteDatasource();

  Future<User> register(String username, String password) async {
  var response = jsonDecode(await remoteDatasource.register(username, password));
  var user = User.fromJson(response);
  return user;
  }

  Future<User?> login(UserLogin user) async {
    try {
      var response = jsonDecode(await remoteDatasource.login(user));
      var userLogin = User.fromJson(response);
      return userLogin;
    } catch (e) {
      rethrow;
    }
  }

  Future<User> getUserById(int userId) async {
    var response = jsonDecode(await remoteDatasource.getUserById(userId));
    var user = User.fromJson(response);
    return user;
  }
}