class UserBalance {
  final int? userId;
  final double userBalance;

  const UserBalance({
    this.userId,
    required this.userBalance
  });

  factory UserBalance.fromMap(Map<String, dynamic> json) => UserBalance(
    userId: json['userId'],
    userBalance: json['userBalance']
  );
  
  Map<String, dynamic> toMap() => {
    'userId': userId,
    'userBalance': userBalance
  };  

}