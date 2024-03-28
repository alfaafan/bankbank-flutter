class Card {
  int cardId;
  String cardNumber;
  DateTime expirationDate;
  String status;
  int userId;

  Card({
    required this.cardId,
    required this.cardNumber,
    required this.expirationDate,
    required this.status,
    required this.userId,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
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