class UserPayment {
  final int? userPaymentId;
  final int? userId;
  final String paymentMethod;
  final double paymentAmt;
  final String paymentDate;

  const UserPayment({
    this.userPaymentId,
    this.userId,
    required this.paymentMethod,
    required this.paymentAmt,
    required this.paymentDate,
  });

  factory UserPayment.fromMap(Map<String, dynamic> json) => UserPayment(
    userPaymentId: json['userPaymentId'],
    userId: json['userId'],
    paymentMethod: json['paymentMethod'],
    paymentAmt: json['paymentAmt'],
    paymentDate: json['paymentDate']
  );
  
  Map<String, dynamic> toMap() => {
    'userPaymentId': userPaymentId,
    'userId': userId,
    'paymentMethod': paymentMethod,
    'paymentAmt': paymentAmt,
    'paymentDate': paymentDate
  };  

}