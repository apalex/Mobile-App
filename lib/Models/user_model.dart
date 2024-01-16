class User {
  final int userId;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNum;
  final String userPassword;
  final String createdOn;
  final int isActive;

  const User({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNum,
    required this.userPassword,
    required this.createdOn,
    required this.isActive
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
    isActive: json['isActive']
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
    'isActive': isActive
  };  

}