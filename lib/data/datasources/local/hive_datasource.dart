import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/model/card.dart';
import 'package:bankbank/data/model/role.dart';
import 'package:bankbank/data/model/user.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDatasource {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(AccountAdapter());
    Hive.registerAdapter(UserCardAdapter());
    Hive.registerAdapter(RoleAdapter());
    await Hive.openBox<User>('userBox');
    await Hive.openBox<Account>('accountBox');
    await Hive.openBox<UserCard>('cardBox');
    await Hive.openBox<Role>('roleBox');
  }
}