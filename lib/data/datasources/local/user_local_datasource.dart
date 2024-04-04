import 'package:bankbank/data/model/account.dart';
import 'package:bankbank/data/model/card.dart';
import 'package:bankbank/data/model/role.dart';
import 'package:bankbank/data/model/user.dart';
import 'package:bankbank/domain/entities/user.dart';
import 'package:hive/hive.dart';

class UserLocalDatasource {
  final Box<User> userBox = Hive.box<User>('userBox');
  final Box<Account> accountBox = Hive.box<Account>('accountBox');
  final Box<UserCard> cardBox = Hive.box<UserCard>('cardBox');
  final Box<Role> roleBox = Hive.box<Role>('roleBox');

  Future<void> saveUser(UserModel user) async {
    var userHive = User(
      userId: user.userId,
      username: user.username,
      email: user.email,
      firstName: user.firstName,
      lastName: user.lastName,
      phone: user.phone,
      dateOfBirth: user.dateOfBirth,
      registrationDate: user.registrationDate,
      lastLoginDate: user.lastLoginDate,
      token: user.token
    );

    await userBox.put('user', userHive);

    for (var account in user.accounts) {
      var accountHive = Account(
        accountId: account.accountId,
        accountNumber: account.accountNumber,
        balance: account.balance,
        accountTypeId: account.accountTypeId,
        userId: account.userId, status: account.status
      );
      await accountBox.put('account', accountHive);
    }

    for (var card in user.cards) {
      var cardHive = UserCard(
        cardId: card.cardId,
        cardNumber: card.cardNumber,
        expirationDate: card.expirationDate,
        status: card.status,
        userId: card.userId
      );
      await cardBox.put('card', cardHive);
    }

    for (var role in user.roles) {
      var roleHive = Role(
        roleName: role.roleName
      );
      await roleBox.put('role', roleHive);
    }
  }

  Future<User?> getUser() async {
    var user = userBox.get('user');
    return user;
  }
}