import 'dart:convert';

import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/domain/entities/user_login.dart';
import 'package:bankbank/domain/entities/user_register.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class UsersRemoteDatasource {
  final http.Client client = http.Client();
  final String baseUrl = 'https://app.actualsolusi.com/bsi/BankBank/api/Users';
  var userBox = Hive.box<User>('userBox');

  Future<String> register(UserRegister user) async {
    final response = await client.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
        body: {
          'Username': user.username,
          'Password': user.password,
          'Email': user.email,
          'FirstName': user.firstName,
          'LastName': user.lastName,
          'Phone': user.phoneNumber,
          'DateOfBirth': user.dateOfBirth,
        }
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register');
    }
    return response.body;
  }

  Future<String> login(UserLogin user) async {
    final response = await client.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode({
          'username': user.username,
          'password': user.password,
        })
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to login');
    }

    return response.body;
  }

  Future<String> getUserById(int userId) async {
    var user = userBox.get('user');
    final response = await client.get(
        Uri.parse('$baseUrl/$userId'),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Authorization': 'Bearer ${user?.token}',
        },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get user');
    }
    return response.body;
  }

  Future<String> getUserByAccountNumber(String accountNumber) async {
    final response = await client.get(
        Uri.parse('$baseUrl/account/$accountNumber'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get user');
    }
    return response.body;
  }
}