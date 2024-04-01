import 'package:bankbank/data/datasources/local/hive_datasource.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/screens/auth/login.dart';
import 'package:bankbank/presentation/screens/home/home.dart';
import 'package:bankbank/presentation/screens/home/landing_page.dart';
// import 'package:bankbank/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveDatasource hive = HiveDatasource();
  await hive.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BankBank',
      theme: ThemeData(
        primarySwatch: AppColors.primaryMaterialColor,
        fontFamily: GoogleFonts.quicksand().fontFamily,
        useMaterial3: true,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}