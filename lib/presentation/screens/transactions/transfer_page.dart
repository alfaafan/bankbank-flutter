import 'package:bankbank/presentation/common/app_bar.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/providers/transaction_provider.dart';
import 'package:bankbank/presentation/screens/transactions/transfer_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TransferPage extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Adjust height as needed
        child: BankBankAppBar(title: 'Transfer'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              'assets/svg/transfer.svg',
              height: 100.0,
            ),
    const SizedBox(height: 36, child: Text('Transfer money', style:
            TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24))),
            const SizedBox(height: 16),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.67,
              child: Card(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )
                ),
                child: Form(
                  key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            controller: amountController,
                            decoration: const InputDecoration(
                              labelText: 'Amount',
                              hintText: 'Enter amount',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter amount';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            controller: recipientController,
                            decoration: const InputDecoration(
                              labelText: 'Recipient account number',
                              hintText: 'Enter recipient account number',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter recipient account number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              hintText: 'Enter description',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Consumer<TransactionProvider>(
                            builder: (context, transactionProvider, child) =>
                            ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TransferConfirmationPage(
                                    amount: amountController.text,
                                    recipient: recipientController.text,
                                    description: descriptionController.text.isEmpty
                                        ? 'No Description' : descriptionController.text)));
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
                                child: transactionProvider.isLoading
                                    ? const CircularProgressIndicator()
                                    : const Text ('Transfer', style: TextStyle(color:
                                Colors.white, fontWeight: FontWeight.bold))
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
