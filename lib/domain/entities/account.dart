class AccountModel {
  int accountId;
  int userId;
  String accountNumber;
  int accountTypeId;
  int balance;
  String status;

  AccountModel({
    required this.accountId,
    required this.userId,
    required this.accountNumber,
    required this.accountTypeId,
    required this.balance,
    required this.status,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
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