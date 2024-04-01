import 'package:bankbank/data/repositories/transaction_repository.dart';
import 'package:bankbank/domain/entities/transaction.dart';

class TransactionUsecase {
  final TransactionRepository repository = TransactionRepository();

  // Future<TransactionModel> createTransaction(TransactionModel transaction)
  // async {
  //   return await repository.createTransaction(transaction);
  // }

  Future<List<TransactionModel>> getTransactionsByAccountId(int id) async {
    return await repository.getTransactionByAccountId(id);
  }
}