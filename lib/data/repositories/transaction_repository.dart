import 'dart:convert';

import 'package:bankbank/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:bankbank/domain/entities/transaction.dart';

class TransactionRepository {
  final TransactionRemoteDatasource remoteDatasource = TransactionRemoteDatasource();

  Future<List<TransactionModel>> getTransactionByAccountId(int accountId) async {
    var response = jsonDecode(await remoteDatasource.getTransactionByAccountId(accountId));
    List<TransactionModel> transactions = [];
    if (response == null) return transactions;
    for (var item in response) {
      transactions.add(TransactionModel.fromJson(item));
    }
    return transactions;
  }
}