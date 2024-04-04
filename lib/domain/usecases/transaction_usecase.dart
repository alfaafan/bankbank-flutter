import 'package:bankbank/data/repositories/transaction_repository.dart';
import 'package:bankbank/domain/entities/transaction.dart';
import 'package:bankbank/domain/entities/transfer.dart';

class TransactionUsecase {
  final TransactionRepository repository = TransactionRepository();

  Future<List<TransactionModel>> getTransactionsByAccountId(int id) async {
    return await repository.getTransactionByAccountId(id);
  }

  Future<TransactionModel> transfer(Transfer transaction) async {
    return await repository.transfer(transaction);
  }
}