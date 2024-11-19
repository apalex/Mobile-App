class UserTransfers {
  final int? userTransferId;
  final int? userId;
  final String coinName;
  final double transferAmt;
  final double usdtAmt;
  final String transactionDate;

  const UserTransfers({
    this.userTransferId,
    this.userId,
    required this.coinName,
    required this.transferAmt,
    required this.usdtAmt,
    required this.transactionDate
  });

  factory UserTransfers.fromMap(Map<String, dynamic> json) => UserTransfers(
    userTransferId: json['userTransferId'],
    userId: json['userId'],
    coinName: json['coinName'],
    transferAmt: json['transferAmt'],
    usdtAmt: json['usdtAmt'],
    transactionDate: json['transactionDate']
  );
  
  Map<String, dynamic> toMap() => {
    'userTransferId': userTransferId,
    'userId': userId,
    'coinName': coinName,
    'transferAmt': transferAmt,
    'usdtAmt': usdtAmt,
    'transactionDate': transactionDate
  };  

}