import 'dart:convert';
import 'account.dart';
import 'card.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int userId;
  String username;
  String email;
  String firstName;
  String lastName;
  String phone;
  DateTime dateOfBirth;
  DateTime registrationDate;
  DateTime lastLoginDate;
  List<Account> accounts;
  List<Card> cards;
  List<String> roles;

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
    required this.accounts,
    required this.cards,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json["UserId"],
    username: json["Username"],
    email: json["Email"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
    phone: json["Phone"],
    dateOfBirth: DateTime.parse(json["DateOfBirth"]),
    registrationDate: DateTime.parse(json["RegistrationDate"]),
    lastLoginDate: DateTime.parse(json["LastLoginDate"]),
    accounts: List<Account>.from(json["Accounts"].map((x) => Account.fromJson(x))),
    cards: List<Card>.from(json["Cards"].map((x) => Card.fromJson(x))),
    roles: List<String>.from(json["Roles"].map((x) => x)),
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