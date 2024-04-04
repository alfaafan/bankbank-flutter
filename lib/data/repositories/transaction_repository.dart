import 'dart:convert';

import 'package:bankbank/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:bankbank/domain/entities/transaction.dart';
import 'package:bankbank/domain/entities/transfer.dart';

class TransactionRepository {
  final TransactionRemoteDatasource remoteDatasource = TransactionRemoteDatasource();

  Future<List<TransactionModel>> getTransactionByAccountId(int accountId) async {
    var response = jsonDecode(await remoteDatasource.getTransactionByAccountId(accountId));
    List<TransactionModel> transactions = [];
    if (response == null) return transactions;
    for (var item in response) {
      transactions.add(TransactionModel.fromJson(item));
    }
    return transactions.reversed.toList();
  }

  Future<TransactionModel> transfer(Transfer transaction) async {
    var response = jsonDecode(await remoteDatasource.transfer(transaction));
    return TransactionModel.fromJson(response);
  }
}