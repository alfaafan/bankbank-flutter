class CardModel {
  int cardId;
  String cardNumber;
  DateTime expirationDate;
  String status;
  int userId;

  CardModel({
    required this.cardId,
    required this.cardNumber,
    required this.expirationDate,
    required this.status,
    required this.userId,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    cardId: json["CardId"],
    cardNumber: json["CardNumber"],
    expirationDate: DateTime.parse(json["ExpirationDate"]),
    status: json["Status"],
    userId: json["UserId"],
  );

  Map<String, dynamic> toJson() => {
    "CardId": cardId,
    "CardNumber": cardNumber,
    "ExpirationDate": expirationDate.toIso8601String(),
    "Status": status,
    "UserId": userId,
  };
}