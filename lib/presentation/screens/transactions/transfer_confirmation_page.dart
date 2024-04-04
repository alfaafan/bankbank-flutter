import 'package:bankbank/presentation/common/app_bar.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/providers/transaction_provider.dart';
import 'package:bankbank/presentation/screens/home/home.dart';
import 'package:bankbank/utils/curreny_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TransferConfirmationPage extends StatelessWidget {

  final String recipient;
  final String amount;
  final String description;

  const TransferConfirmationPage(
      {super.key, required this.recipient, required this.amount, required this.description});

  @override
  Widget build(BuildContext context) {
    Provider.of<TransactionProvider>(context, listen: false).setRecipient
      (recipient);
    return Scaffold(
      backgroundColor: AppColors.blueDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Adjust height as needed
        child: BankBankAppBar(title: 'Transfer Confirmation'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/svg/confirm.svg', height: 100.0),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Consumer<TransactionProvider>(
                    builder: (context, transactionProvider, child) {
                      if (transactionProvider.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (transactionProvider.recipient == null) {
                        return const Center(child: Text('Recipient not found'));
                      } else {
                        return Column(
                          children: [
                            ListTile(
                              title: const Text('Recipient Account Number', style:
                              TextStyle(
                                  fontSize: 12)),
                              subtitle: Text(transactionProvider.recipient!
                                  .accounts.first.accountNumber,
                                  style: const
                                  TextStyle(
                                      fontSize: 14, color: AppColors.blueDark,
                                      fontWeight:
                                      FontWeight.bold)),
                            ),ListTile(
                              title: const Text('Recipient Name', style:
                              TextStyle(
                                  fontSize: 12)),
                              subtitle: Text("${transactionProvider.recipient!.firstName} ${transactionProvider.recipient!.lastName}",
                                  style: const
                                  TextStyle(
                                      fontSize: 14, color: AppColors.blueDark,
                                      fontWeight:
                                      FontWeight.bold)),
                            ),
                            ListTile(
                              title: const Text('Amount', style: TextStyle(
                                  fontSize: 12)),
                              subtitle: Text(CurrencyFormatter.formatToIdr
                                (double.parse(amount)), style: const
                              TextStyle(
                                  fontSize: 14, color: AppColors.blueDark,
                                  fontWeight:
                                  FontWeight.bold)),
                            ),
                            ListTile(
                              title: const Text('Description', style: TextStyle(
                                  fontSize: 12)),
                              subtitle: Text(description, style: const TextStyle(
                                  fontSize: 14, color: AppColors.blueDark,
                                  fontWeight:
                                  FontWeight.bold)),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                                onPressed: () async {
                                  var recipientId = transactionProvider.recipient!
                                      .accounts.first.accountId;
                                  var transaction = await Provider
                                  .of<TransactionProvider>(context,
                                      listen: false).transfer(recipientId, amount,
                                      description);
                                  if (transaction != null) {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: (context)
                                    => const HomePage()));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blueDark,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 48,
                                      vertical: 18), // Button padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10), // Button border radius
                                  ),
                                ),
                                child: const Text ('Confirm Transfer', style:
                                TextStyle(color:
                                Colors.white, fontWeight: FontWeight.bold))
                            ),
                          ],
                        );
                      }
                    }
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
