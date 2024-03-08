class PortfolioModel {
  final int? userPortfolioId;
  final int? userId;
  final String coinName;
  final double coinAmt;

  const PortfolioModel({
    this.userPortfolioId,
    this.userId,
    required this.coinName,
    required this.coinAmt
  });

  factory PortfolioModel.fromMap(Map<String, dynamic> json) => PortfolioModel(
    userPortfolioId: json['userPortfolioId'],
    userId: json['userId'],
    coinName: json['coinName'],
    coinAmt: json['coinAmt']
  );

  Map<String, dynamic> toMap() => {
    'userPortfolioId': userPortfolioId,
    'userId': userId,
    'coinName': coinName,
    'coinAmt': coinAmt
  };

}