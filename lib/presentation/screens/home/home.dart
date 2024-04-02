import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/model/card.dart';
import 'package:bankbank/data/model/role.dart';
import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/data/repositories/user_repository.dart';
import 'package:bankbank/domain/usecases/transaction_usecase.dart';
import 'package:bankbank/domain/usecases/user_usecase.dart';
import 'package:bankbank/presentation/common/drawer.dart';
import 'package:bankbank/presentation/common/theme_data.dart';
import 'package:bankbank/presentation/providers/account_provider.dart';
import 'package:bankbank/presentation/providers/transaction_provider.dart';
import 'package:bankbank/presentation/screens/auth/login.dart';
import 'package:bankbank/utils/curreny_formatter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserUsecase userUsecase;
  late final TransactionUsecase transactionUsecase;
  bool isHidden = true;

  @override
  void initState() {
    super.initState();
    context.read<AccountProvider>().fetchAccount();
    context.read<TransactionProvider>().fetchTransactionsById();
    userUsecase = UserUsecase(UserRepository());
    transactionUsecase = TransactionUsecase();
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
    var user = userBox.get('user');
    var accountBox = Hive.box<Account>('accountBox');
    var account = accountBox.get('account');
    var cardBox = Hive.box<UserCard>('cardBox');
    cardBox.get('card');
    var roleBox = Hive.box<Role>('roleBox');
    roleBox.get('role');

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
                  "Hello, ${user?.firstName.toUpperCase()}!",
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Consumer<AccountProvider>(
                builder: (context, accountProvider, child) => Card(
                  margin: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            const Icon(Icons.account_balance_wallet, color: AppColors.blueDark),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Account',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.blueDark,
                                  ),
                                ),
                                Text(
                                  accountProvider.account?.accountNumber ?? 'No Account',
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.blueDark,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ListTile(
                        title: const Text(
                          'Balance'
                        ),
                        subtitle: accountProvider.isHidden
                            ? const Text('Rp *********', style: TextStyle(color: AppColors.blueDark,
                            fontWeight: FontWeight
                                .bold, fontSize: 18))
                            : Text(CurrencyFormatter.formatToIdr
                          (accountProvider.account?.balance ?? 0.0), style:
                        const TextStyle
                          (color: AppColors.blueDark, fontWeight: FontWeight
                            .bold, fontSize: 18),),
                        trailing: TextButton(
                          onPressed: () {
                            accountProvider.toggleVisibility();
                          },
                          child: const Icon(Icons.remove_red_eye, color:
                          AppColors.blueDark),
                        ),
                      )
                    ],
                  ),
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
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                )),
                child: Consumer<TransactionProvider>(
                  builder: (context, transactionProvider, child) {
                    // Check loading, error, and empty states based on provider data
                    if (transactionProvider.isLoading) {
                      return const Padding(
                        padding: EdgeInsets.fromLTRB(24, 56, 24, 56),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else if (transactionProvider.transactions.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.fromLTRB(24, 56, 24, 56),
                        child: Center(child: Column(
                          children: [
                            Icon(Icons.error, color: Colors.red),
                            SizedBox(height: 10),
                            Text('No Transaction',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                          ],
                        )),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            var transaction = transactionProvider.transactions[index];
                            return ListTile(
                              title: Text(transaction.description ?? 'No '
                                  'description'),
                              subtitle: Text(DateFormat('yyyy-MM-dd HH:mm')
                                  .format(transaction.transactionDate),
                                  style: const TextStyle(fontSize: 12)),
                              trailing: (transaction.sourceAccountId !=
                                  account!.accountId ||
                                  transaction.transactionCategoryId == 3)
                                  ? Text('-${CurrencyFormatter.formatToIdr(transaction.amount as double)}',
                                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold))
                                  : Text('+${CurrencyFormatter.formatToIdr(transaction.amount as double)}',
                                  style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(color: Colors.grey);
                          }
                        ),
                      );
                    }
                  },
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
