import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:flutter/material.dart';

class BankBankAppBar extends StatelessWidget {
  final String title;
  const BankBankAppBar({super.key, required this.title});


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blueDark,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(title, style: const TextStyle(color: Colors.white,
          fontWeight:
          FontWeight.bold, fontSize: 16),
    ));
  }
}
