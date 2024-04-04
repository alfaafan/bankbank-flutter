import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/providers/transaction_provider.dart';
import 'package:bankbank/utils/curreny_formatter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionHistoryPage extends StatelessWidget {
  // Provider.of<TransactionProvider>(context, listen: false).fetchTransactionsById();

  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueDark,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: AppColors.blueDark,
        title: const Text('Transaction History', style: TextStyle(color:
        Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          if (transactionProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactionProvider.transactions.length,
                      itemBuilder: (context, index) {
                        var accountBox = Hive.box<Account>('accountBox');
                        var account = accountBox.get('account');
                        var transaction = transactionProvider.transactions[index];
                        return ListTile(
                          title: Text(transaction.description ?? 'No '
                              'description', style: const TextStyle
                            (fontSize: 14, fontWeight: FontWeight.bold, color:
                          AppColors.blueDark)),
                          subtitle: Text(DateFormat('yyyy-MM-dd HH:mm')
                              .format(transaction.transactionDate),
                              style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          trailing: (transaction.sourceAccountId !=
                              account!.accountId ||
                              transaction.transactionCategoryId == 3)
                              ? Text('- ${CurrencyFormatter.formatToIdr
                            (transaction.amount)}',
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                              : Text('+ ${CurrencyFormatter.formatToIdr
                            (transaction.amount)}',
                              style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(color: Colors.grey,
                            thickness: 0.2);
                      }
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
