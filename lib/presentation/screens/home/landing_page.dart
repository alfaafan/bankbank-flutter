import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/screens/auth/login.dart';
import 'package:bankbank/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to BankBank',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Banking at Your Fingertips',
              style: TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 40.0),
            SvgPicture.asset(
              'assets/svg/bank.svg',
              height: 200.0,
            ),
            const SizedBox(height: 60.0),
            Card(
              margin: const EdgeInsets.all(16.0),
              color: AppColors.blueDark,
              child: ListTile(
                leading: const Icon(Icons.login, color: Colors.white,),
                title: const Text('Log in', style: TextStyle(color: Colors
                    .white)),
                onTap: () {
                  // Navigate to the login page
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => const LoginPage()));
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              color: AppColors.blueMedium,
              child: ListTile(
                leading: const Icon(Icons.person_add, color: Colors.white),
                title: const Text('Sign up', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Navigate
                  Navigator.push(context, MaterialPageRoute(builder:
                      (context) => const HomePage()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}