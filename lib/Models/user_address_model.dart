class UserAddress {
  final int? userId;
  final String address1;
  final String address2;
  final String country;
  final String province;
  final String city;
  final String zipCode;

  const UserAddress({
    this.userId,
    required this.address1,
    required this.address2,
    required this.country,
    required this.province,
    required this.city,
    required this.zipCode
  });

  factory UserAddress.fromMap(Map<String, dynamic> json) => UserAddress(
    userId: json['userId'],
    address1: json['address1'],
    address2: json['address2'],
    country: json['country'],
    province: json['province'],
    city: json['city'],
    zipCode: json['zipCode']
  );
  
  Map<String, dynamic> toMap() => {
    'userId': userId,
    'address1': address1,
    'address2': address2,
    'country': country,
    'province': province,
    'city': city,
    'zipCode': zipCode
  };  

}