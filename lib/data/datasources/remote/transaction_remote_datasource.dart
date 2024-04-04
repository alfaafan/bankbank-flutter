import 'dart:convert';

import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/domain/entities/transfer.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class TransactionRemoteDatasource {
  final http.Client client = http.Client();
  final String baseUrl = 'https://app.actualsolusi'
      '.com/bsi/bankbank/api/transactions';
  var box = Hive.box<User>('userBox');
  var accountBox = Hive.box<Account>('accountBox');

  Future<String> getTransactionByAccountId(int accountId) async {
    var user = box.get('user');
    final response = await client.get(
      Uri.parse('$baseUrl/account/$accountId'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer ${user?.token}'
      },
    );

    if (response.statusCode == 404) {
      return '[]';
    }

    if (response.statusCode != 200) {
      throw Exception('Failed to get transaction');
    }
    return response.body;
  }

  Future<String> transfer(Transfer transaction) async {
    var user = box.get('user');
    var account = accountBox.get('account');
    final response = await client.post(
      Uri.parse('$baseUrl/transfer'),
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Authorization': 'Bearer ${user?.token}'
      },
      body: jsonEncode({
        'SourceAccountID': account?.accountId,
        'ReceiverAccountID': transaction.recipient,
        'Amount': transaction.amount,
        'Description': transaction.description,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to transfer');
    }

    return response.body;
  }
}