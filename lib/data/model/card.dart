import 'package:hive/hive.dart';

part 'card.g.dart';

@HiveType(typeId: 3)
class UserCard extends HiveObject {
  @HiveField(0)
  final int cardId;

  @HiveField(1)
  final String cardNumber;

  @HiveField(2)
  final DateTime expirationDate;

  @HiveField(3)
  final String status;

  @HiveField(4)
  final int userId;

  UserCard({
    required this.cardId,
    required this.cardNumber,
    required this.expirationDate,
    required this.status,
    required this.userId,
  });
}