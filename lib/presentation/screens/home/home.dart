import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/model/card.dart';
import 'package:bankbank/data/model/role.dart';
import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/usecases/user_usecase.dart';
import 'package:bankbank/presentation/common/drawer.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/screens/auth/login.dart';
import 'package:bankbank/utils/curreny_formatter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserUsecase userUsecase;
  bool isHidden = true;

  @override
  void initState() {
    super.initState();
    userUsecase = UserUsecase(UserRepository());
  }


  @override
  Widget build(BuildContext context) {
    var userBox = Hive.box<User>('userBox');
    if (userBox.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return const LoginPage();
        }));
      });
    }
    var user = userBox.getAt(0);
    var accountBox = Hive.box<Account>('accountBox');
    var account = accountBox.getAt(0);
    var cardBox = Hive.box<UserCard>('cardBox');
    var card = cardBox.getAt(0);
    var roleBox = Hive.box<Role>('roleBox');
    var role = roleBox.getAt(0);

    return Scaffold(
      backgroundColor: AppColors.blueDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 180.0,
            backgroundColor: AppColors.blueDark,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Row(
                children: [
                  Icon(Icons.account_balance_wallet, color: Colors.white),
                  SizedBox(width: 10),
                  Text('BankBank'),
                ],
              ),
              background: Container(
                color: AppColors.blueDark, // Ensure consistent background color
              ),
            ),
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Welcome, ${user?.username.toUpperCase()}!",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          const Icon(Icons.account_balance_wallet, color: AppColors.blueDark),
                          const SizedBox(width: 10),
                          Text(
                            'Account ${account?.accountNumber}',
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blueDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Balance',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: isHidden
                          ? const Text('Rp. *********')
                          : Text(CurrencyFormatter.formatToIdr(account!
                          .balance), style:
                      const TextStyle
                        (color: AppColors.blueDark),),
                      trailing: TextButton(
                        onPressed: () {
                          setState(() {
                            isHidden = !isHidden;
                          });
                        },
                        child: const Icon(Icons.remove_red_eye, color:
                        AppColors.blueDark),
                      ),
                    )
                  ],
                ),
              ),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      child: const Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.payments, color: AppColors.blueDark),
                            SizedBox(height: 10),
                            Text('Transfer'),
                          ],
                        )
                      ),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return AccountPage();
                        // }));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      child: const Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.receipt_long, color: AppColors.blueDark),
                            SizedBox(height: 10),
                            Text('Pay Bills'),
                          ],
                        )
                      ),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return CardPage();
                        // }));
                        print('card pressed');
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: InkWell(
                      child: const Card(
                        margin: EdgeInsets.zero,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history, color: AppColors.blueDark),
                            SizedBox(height: 10),
                            Text('History'),
                          ],
                        )
                      ),
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return HistoryPage();
                        // }));
                        print('history pressed');
                      },
                    ),
                  ),
                ]
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Recent Transactions',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Card(
                margin: EdgeInsets.zero,
                child: Column(
                  children: List.generate(
                    10,
                        (index) => ListTile(
                      title: Text(
                        'Transaksi ${index + 1}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text('22-01-24 08:00'),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      drawer: const AppDrawer(),
    );
  }
}
