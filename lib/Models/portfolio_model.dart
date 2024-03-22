class PortfolioModel {
  final int? userPortfolioId;
  final int? userId;
  final String coinName;
  final double coinAmt;
  final double averageBuyPrice;

  const PortfolioModel({
    this.userPortfolioId,
    this.userId,
    required this.coinName,
    required this.coinAmt,
    required this.averageBuyPrice
  });

  factory PortfolioModel.fromMap(Map<String, dynamic> json) => PortfolioModel(
    userPortfolioId: json['userPortfolioId'],
    userId: json['userId'],
    coinName: json['coinName'],
    coinAmt: json['coinAmt'],
    averageBuyPrice: json['averageBuyPrice']
  );

  Map<String, dynamic> toMap() => {
    'userPortfolioId': userPortfolioId,
    'userId': userId,
    'coinName': coinName,
    'coinAmt': coinAmt,
    'averageBuyPrice': averageBuyPrice
  };

}