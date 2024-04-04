class Transfer {
  final double amount;
  final int recipient;
  final String description;

  Transfer({
    required this.amount,
    required this.recipient,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'recipient': recipient,
      'description': description,
    };
  }
}