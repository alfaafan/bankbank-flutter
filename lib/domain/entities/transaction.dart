// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

TransactionModel transactionFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel {
  int transactionId;
  int transactionCategoryId;
  dynamic transactionCategory;
  int userId;
  int? sourceAccountId;
  int? receiverAccountId;
  dynamic receiverAccountNumber;
  dynamic billId;
  double amount;
  String? description;
  DateTime transactionDate;
  String status;

  TransactionModel({
    required this.transactionId,
    required this.transactionCategoryId,
    this.transactionCategory,
    required this.userId,
    this.sourceAccountId,
    this.receiverAccountId,
    this.receiverAccountNumber,
    this.billId,
    required this.amount,
    this.description,
    required this.transactionDate,
    required this.status,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    transactionId: json["TransactionID"],
    transactionCategoryId: json["TransactionCategoryID"],
    transactionCategory: json["TransactionCategory"],
    userId: json["UserID"],
    sourceAccountId: json["SourceAccountID"],
    receiverAccountId: json["ReceiverAccountID"],
    receiverAccountNumber: json["ReceiverAccountNumber"],
    billId: json["BillID"],
    amount: json["Amount"],
    description: json["Description"],
    transactionDate: DateTime.parse(json["TransactionDate"]),
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "TransactionID": transactionId,
    "TransactionCategoryID": transactionCategoryId,
    "TransactionCategory": transactionCategory,
    "UserID": userId,
    "SourceAccountID": sourceAccountId,
    "ReceiverAccountID": receiverAccountId,
    "ReceiverAccountNumber": receiverAccountNumber,
    "BillID": billId,
    "Amount": amount,
    "Description": description,
    "TransactionDate": transactionDate.toIso8601String(),
    "Status": status,
  };
}
