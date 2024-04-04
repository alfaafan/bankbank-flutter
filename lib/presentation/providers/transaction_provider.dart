import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/repositories/transaction_repository.dart';
import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/entities/role.dart';
import 'package:bankbank/domain/entities/transaction.dart';
import 'package:bankbank/domain/entities/transfer.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:bankbank/domain/usecases/user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TransactionProvider extends ChangeNotifier {
  final UserUsecase _userUsecase = UserUsecase(UserRepository());
  final TransactionRepository _transactionRepository = TransactionRepository();
  UserModel? _recipient;
  List<TransactionModel> _transactions = [];
  var accountBox = Hive.box<Account>('accountBox');

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  List<TransactionModel> get transactions => _transactions;
  UserModel? get recipient => _recipient;



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

  void setRecipient(String recipientAccountNumber) async {
    _isLoading = true;
    try {
      _recipient = await _userUsecase.getUserByAccountNumber(recipientAccountNumber);
      List<RoleModel> roles = ["customer"].map((e) => RoleModel(roleName: e))
          .toList();
      _recipient?.roles = roles;
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

  Future<TransactionModel> transfer(int recipient, String amount, String
  description)
  async {
    _isLoading = true;
    notifyListeners();

    var transaction = Transfer(
      recipient: recipient,
      amount: double.parse(amount),
      description: description,
    );

    try {
      var transfer = await _transactionRepository.transfer(transaction);
      fetchTransactionsById();
      return transfer;
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}