import 'package:bankbank/data/model/user.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class TransactionRemoteDatasource {
  final http.Client client = http.Client();
  final String baseUrl = 'https://app.actualsolusi'
      '.com/bsi/bankbank/api/transactions/';

  Future<String> getTransactionByAccountId(int accountId) async {
    var box = Hive.box<User>('userBox');
    var user = box.get('user');
    final response = await client.get(
      Uri.parse('${baseUrl}account/$accountId'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer ${user?.token}'
      },
    );

    // if (response.statusCode == 404) {
    //   return "";
    // }

    if (response.statusCode != 200) {
      throw Exception('Failed to get transaction');
    }
    return response.body;
  }

  // Future<String> transfer()
}