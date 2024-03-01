class UserActivity {
  final int? userActivityId;
  final int? userId;
  final String activityTimeStamp;
  final String ipAddress;

  const UserActivity({
    this.userActivityId,
    this.userId,
    required this.activityTimeStamp,
    required this.ipAddress
  });

  factory UserActivity.fromMap(Map<String, dynamic> json) => UserActivity(
    userActivityId: json['userActivityId'],
    userId: json['userId'],
    activityTimeStamp: json['activityTimeStamp'],
    ipAddress: json['ipAddress']
  );

  Map<String, dynamic> toMap() => {
    'userActivityId': userActivityId,
    'userId': userId,
    'activityTimeStamp': activityTimeStamp,
    'ipAddress': ipAddress
  };

}