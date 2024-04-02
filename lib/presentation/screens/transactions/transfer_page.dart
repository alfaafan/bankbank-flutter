import 'package:bankbank/presentation/common/app_bar.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransferPage extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController recipientController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blueDark,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight), // Adjust height as needed
        child: BankBankAppBar(title: 'Transfer'),
      ),
      body: Column(
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
            height: MediaQuery.of(context).size.height * 0.6,
            child: Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
              ),
              child: Form(
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
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          controller: recipientController,
                          decoration: const InputDecoration(
                            labelText: 'Recipient',
                            hintText: 'Enter recipient',
                          ),
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
                        ElevatedButton(
                            onPressed: () {
                              // Add transfer logic here
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
                            child: const Text ('Transfer', style: TextStyle(color:
                            Colors.white, fontWeight: FontWeight.bold))
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
