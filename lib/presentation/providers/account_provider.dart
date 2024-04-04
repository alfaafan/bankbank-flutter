import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/repositories/account_repository.dart';
import 'package:bankbank/domain/entities/account.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AccountProvider extends ChangeNotifier {
  final AccountRepository _accountRepository = AccountRepository();
  AccountModel? _account;
  double balance = 0.0;
  bool isHidden = true;
  bool _isLoading = false;

  AccountModel? get account => _account;
  bool get isLoading => _isLoading;

  Future<void> fetchAccount() async {
    _isLoading = true;
    notifyListeners();
    var accountBox = Hive.box<Account>('accountBox');
    var accountHive = accountBox.get('account');
    try {
      final account = await _accountRepository.getAccount(accountHive!.accountId);
      setAccount(account);
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setAccount(AccountModel account) {
    _account = account;
    balance = account.balance;
    notifyListeners();
  }

  void toggleVisibility() {
    isHidden = !isHidden;
    notifyListeners();
  }
}