import 'package:hive/hive.dart';

part 'account.g.dart';

@HiveType(typeId: 2)
class Account extends HiveObject {
  @HiveField(0)
  final int accountId;

  @HiveField(1)
  final int userId;

  @HiveField(2)
  final String accountNumber;

  @HiveField(3)
  final int accountTypeId;

  @HiveField(4)
  final int balance;

  @HiveField(5)
  final String status;

  Account({
    required this.accountId,
    required this.userId,
    required this.accountNumber,
    required this.accountTypeId,
    required this.balance,
    required this.status,
  });
}