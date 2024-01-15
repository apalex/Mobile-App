class User {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phoneNum;
  final String password;
  final String createdOn;

  const User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNum,
    required this.password,
    required this.createdOn,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    firstName: json['firstName'],
    lastName: json['lastName'],
    username: json['username'],
    email: json['email'],
    phoneNum: json['phoneNum'],
    password: json['password'],
    createdOn: json['createdOn']
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'username': username,
    'email': email,
    'phoneNum': phoneNum,
    'password': password,
    'createdOn': createdOn
  };  

}