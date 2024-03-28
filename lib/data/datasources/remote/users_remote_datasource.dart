import 'package:bankbank/domain/entities/user_login.dart';
import 'package:http/http.dart' as http;

class UsersRemoteDatasource {
  final http.Client client;

  UsersRemoteDatasource({required this.client});

  Future<String> register(String username, String password) async {
    final response = await client.post(
        Uri.parse('https://bankbank.com/register'),
        body: {
          'username': username,
          'password': password,
        }
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to register');
    }
    return response.body;
  }

  Future<String> login(UserLogin user) async {
    final response = await client.post(
        Uri.parse('https://bankbank.com/login'),
        body: {
          'username': user.username,
          'password': user.password,
        }
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to login');
    }
    return response.body;
  }
}