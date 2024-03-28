// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));

String transactionToJson(Transaction data) => json.encode(data.toJson());

class Transaction {
  int transactionId;
  int transactionCategoryId;
  dynamic transactionCategory;
  int userId;
  int sourceAccountId;
  int receiverAccountId;
  dynamic receiverAccountNumber;
  dynamic billId;
  int amount;
  dynamic description;
  DateTime transactionDate;
  String status;

  Transaction({
    required this.transactionId,
    required this.transactionCategoryId,
    required this.transactionCategory,
    required this.userId,
    required this.sourceAccountId,
    required this.receiverAccountId,
    required this.receiverAccountNumber,
    required this.billId,
    required this.amount,
    required this.description,
    required this.transactionDate,
    required this.status,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
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
