import 'dart:convert';
import 'package:bankbank/data/datasources/local/user_local_datasource.dart';
import 'package:bankbank/data/datasources/remote/users_remote_datasource.dart';
import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/entities/user_login.dart';
import 'package:bankbank/domain/entities/user_register.dart';
import 'package:hive/hive.dart';

class UserRepository {
  final UsersRemoteDatasource remoteDatasource = UsersRemoteDatasource();
  final UserLocalDatasource localDatasource = UserLocalDatasource();

  Future<UserModel> register(UserRegister user) async {
    try {
      var response = jsonDecode(await remoteDatasource.register(user));
      var userRegister = UserModel.fromJson(response);

      return userRegister;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> login(UserLogin user) async {
    try {
      var response = jsonDecode(await remoteDatasource.login(user));
      var userLogin = UserModel.fromJson(response);

      await localDatasource.saveUser(userLogin);

      return userLogin;
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(int userId) async {
    var response = jsonDecode(await remoteDatasource.getUserById(userId));
    var user = UserModel.fromJson(response);
    return user;
  }

  Future<UserModel> getUserByAccountNumber(String accountNumber) async {
    var response = jsonDecode(await remoteDatasource.getUserByAccountNumber(accountNumber));
    var user = UserModel.fromJson(response);
    return user;
  }

  Future<User?> getUserLogin() async {
    var user = await localDatasource.getUser();
    return user;
  }
}