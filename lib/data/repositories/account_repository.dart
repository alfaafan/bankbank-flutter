import 'dart:convert';

import 'package:bankbank/data/datasources/remote/account_remote_datasource.dart';
import 'package:bankbank/domain/entities/account.dart';

class AccountRepository {
  final AccountRemoteDatasource datasource = AccountRemoteDatasource();

  AccountRepository();

  Future<AccountModel> getAccount(int id) async {
    var accounts = jsonDecode(await datasource.getAccountByUserId(id));
    return AccountModel.fromJson(accounts);
  }
}