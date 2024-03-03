class UserTransfers {
  final int? userTransferId;
  final int? userId;
  final String coinName;
  final double transferAmt;

  const UserTransfers({
    this.userTransferId,
    this.userId,
    required this.coinName,
    required this.transferAmt
  });

  factory UserTransfers.fromMap(Map<String, dynamic> json) => UserTransfers(
    userTransferId: json['userTransferId'],
    userId: json['userId'],
    coinName: json['coinName'],
    transferAmt: json['transferAmt']
  );
  
  Map<String, dynamic> toMap() => {
    'userTransferId': userTransferId,
    'userId': userId,
    'coinName': coinName,
    'transferAmt': transferAmt
  };  

}