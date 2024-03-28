class Account {
  int accountId;
  int userId;
  String accountNumber;
  int accountTypeId;
  int balance;
  String status;

  Account({
    required this.accountId,
    required this.userId,
    required this.accountNumber,
    required this.accountTypeId,
    required this.balance,
    required this.status,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
    accountId: json["AccountId"],
    userId: json["UserId"],
    accountNumber: json["AccountNumber"],
    accountTypeId: json["AccountTypeId"],
    balance: json["Balance"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "AccountId": accountId,
    "UserId": userId,
    "AccountNumber": accountNumber,
    "AccountTypeId": accountTypeId,
    "Balance": balance,
    "Status": status,
  };
}