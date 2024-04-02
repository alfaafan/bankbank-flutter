import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/data/repositories/transaction_repository.dart';
import 'package:bankbank/domain/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TransactionProvider extends ChangeNotifier {
  final TransactionRepository _transactionRepository = TransactionRepository();
  var accountBox = Hive.box<Account>('accountBox');
  List<TransactionModel> _transactions = [];
  bool _isLoading = false;

  List<TransactionModel> get transactions => _transactions;

  bool get isLoading => _isLoading;

  Future<void> fetchTransactionsById() async {
    var account = accountBox.get('account');
    var accountId = account!.accountId;
    _isLoading = true;
    notifyListeners();
    try {
      final transactions = await _transactionRepository
          .getTransactionByAccountId(accountId);
      setTransactions(transactions);
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setTransactions(List<TransactionModel> transactions) {
    _transactions = transactions;
    notifyListeners();
  }
}