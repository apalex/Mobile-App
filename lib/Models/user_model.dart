class User {
  final int? userId;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNum;
  final String userPassword;
  final String? createdOn;
  final int? isActive;
  final String? permissions;

  const User({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNum,
    required this.userPassword,
    this.createdOn,
    this.isActive,
    this.permissions
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
    userId: json['userId'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    username: json['username'],
    email: json['email'],
    phoneNum: json['phoneNum'],
    userPassword: json['userPassword'],
    createdOn: json['createdOn'],
    isActive: json['isActive'],
    permissions: json['permissions']
  );
  
  Map<String, dynamic> toMap() => {
    'userId': userId,
    'firstName': firstName,
    'lastName': lastName,
    'username': username,
    'email': email,
    'phoneNum': phoneNum,
    'userPassword': userPassword,
    'createdOn': createdOn,
    'isActive': isActive,
    'permissions': permissions
  };  

}