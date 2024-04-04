import 'package:bankbank/data/model/user.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class AccountRemoteDatasource {
  final http.Client client = http.Client();
  final String baseUrl = 'https://app.actualsolusi'
      '.com/bsi/bankbank/api/Accounts';
  AccountRemoteDatasource();

  Future<String> getAccountByUserId(int userId) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    final response = await client.get(
      Uri.parse('$baseUrl/$userId'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer ${user?.token}'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get account');
    }
    return response.body;
  }
}