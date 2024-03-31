import 'dart:convert';
import 'package:bankbank/data/datasources/remote/users_remote_datasource.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/entities/user_login.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final UsersRemoteDatasource remoteDatasource = UsersRemoteDatasource(client: http.Client());

  Future<User> register(String username, String password) async {
  var response = jsonDecode(await remoteDatasource.register(username, password));
  var user = User.fromJson(response);
  return user;
  }

  Future<User?> login(UserLogin user) async {
    var response = jsonDecode(await remoteDatasource.login(user));
    var userLogin = User.fromJson(response);
    return userLogin;
  }

  Future<User> getUserById(int userId) async {
    var response = jsonDecode(await remoteDatasource.getUserById(userId));
    var user = User.fromJson(response);
    return user;
  }
}