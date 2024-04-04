import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String firstName;

  @HiveField(4)
  final String lastName;

  @HiveField(5)
  final String phone;

  @HiveField(6)
  final DateTime dateOfBirth;

  @HiveField(7)
  final DateTime registrationDate;

  @HiveField(8)
  final DateTime lastLoginDate;

  @HiveField(9)
  final String? token;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.dateOfBirth,
    required this.registrationDate,
    required this.lastLoginDate,
    this.token,
  });
}
