class PortfolioModel {
  final int? userId;
  final String coinName;
  final double coinAmt;

  const PortfolioModel({
    this.userId,
    required this.coinName,
    required this.coinAmt
  });

  factory PortfolioModel.fromMap(Map<String, dynamic> json) => PortfolioModel(
    userId: json['userId'],
    coinName: json['coinName'],
    coinAmt: json['coinAmt']
  );

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'coinName': coinName,
    'coinAmt': coinAmt
  };

}