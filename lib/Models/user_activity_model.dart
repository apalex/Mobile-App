class UserActivity {
  final int? userActivityId;
  final int? userId;
  final String activityTimeStamp;

  const UserActivity({
    this.userActivityId,
    this.userId,
    required this.activityTimeStamp
  });

  factory UserActivity.fromMap(Map<String, dynamic> json) => UserActivity(
    userActivityId: json['userActivityId'],
    userId: json['userId'],
    activityTimeStamp: json['activityTimeStamp']
  );

  Map<String, dynamic> toMap() => {
    'userActivityId': userActivityId,
    'userId': userId,
    'activityTimeStamp': activityTimeStamp
  };

}