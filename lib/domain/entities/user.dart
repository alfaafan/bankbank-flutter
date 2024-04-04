import 'dart:convert';
import 'package:bankbank/domain/entities/role.dart';

import 'account.dart';
import 'card.dart';

UserModel userFromJson(String str) => UserModel.fromJson(json.decode(str));

String userToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  int userId;
  String username;
  String email;
  String firstName;
  String lastName;
  String phone;
  DateTime dateOfBirth;
  DateTime registrationDate;
  DateTime lastLoginDate;
  List<AccountModel> accounts;
  List<CardModel> cards;
  List<RoleModel> roles;
  String? token;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.dateOfBirth,
    required this.registrationDate,
    required this.lastLoginDate,
    required this.accounts,
    required this.cards,
    required this.roles,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json["UserId"],
    username: json["Username"],
    email: json["Email"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    phone: json["Phone"],
    dateOfBirth: DateTime.parse(json["DateOfBirth"]),
    registrationDate: DateTime.parse(json["RegistrationDate"]),
    lastLoginDate: DateTime.parse(json["LastLoginDate"]),
    accounts: List<AccountModel>.from(json["Accounts"].map((x) => AccountModel.fromJson(x))),
    cards: List<CardModel>.from(json["Cards"].map((x) => CardModel.fromJson(x))),
    roles: List<RoleModel>.from(json["Roles"].map((x) => RoleModel.fromJson
      (x))),
    token: json["Token"],
  );

  Map<String, dynamic> toJson() => {
    "UserId": userId,
    "Username": username,
    "Email": email,
    "FirstName": firstName,
    "LastName": lastName,
    "Phone": phone,
    "DateOfBirth": "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
    "RegistrationDate": registrationDate.toIso8601String(),
    "LastLoginDate": lastLoginDate.toIso8601String(),
    "Accounts": List<dynamic>.from(accounts.map((x) => x.toJson())),
    "Cards": List<dynamic>.from(cards.map((x) => x.toJson())),
    "Roles": List<dynamic>.from(roles.map((x) => x)),
  };
}