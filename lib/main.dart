import 'package:bankbank/data/datasources/local/hive_datasource.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/providers/account_provider.dart';
import 'package:bankbank/presentation/providers/transaction_provider.dart';
import 'package:bankbank/presentation/providers/user_provider.dart';
import 'package:bankbank/presentation/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton(HiveDatasource());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveDatasource hive = HiveDatasource();
  await hive.init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AccountProvider()),
    ChangeNotifierProvider(create: (context) => TransactionProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ],
  child: const MyApp(),
  )
  );
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