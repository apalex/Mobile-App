import 'package:crypto_app/Models/user_activity_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto_app/Models/user_model.dart';

class DatabaseHelper {
  final databaseName = 'mintless.db';

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, version) async {
      // User_Info
      await db.execute("CREATE TABLE IF NOT EXISTS User_Info (userId INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT NOT NULL, lastName TEXT NOT NULL, username TEXT NOT NULL UNIQUE, email TEXT NOT NULL UNIQUE, userPassword TEXT NOT NULL, phoneNum TEXT NOT NULL, createdOn TEXT DEFAULT CURRENT_TIMESTAMP, isActive INTEGER DEFAULT 1, permissions TEXT DEFAULT 'User');");
      // User_Address
      await db.execute("CREATE TABLE IF NOT EXISTS User_Address (userId INTEGER PRIMARY KEY, address1 TEXT, address2 TEXT, country TEXT, province TEXT, city TEXT, zipCode TEXT, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Portfolio
      await db.execute("CREATE TABLE IF NOT EXISTS User_Portfolio (userId INTEGER, overallBal REAL DEFAULT 0, fundingBal REAL DEFAULT 0, tradingBal REAL DEFAULT 0, marginBal REAL DEFAULT 0, futureBal REAL DEFAULT 0, botBal REAL DEFAULT 0, financeBal REAL DEFAULT 0, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Activity
      await db.execute("CREATE TABLE IF NOT EXISTS User_Activity (userActivityId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, activityTimeStamp TEXT DEFAULT CURRENT_TIMESTAMP, ip_address TEXT, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Transfers
      await db.execute("CREATE TABLE IF NOT EXISTS User_Transfers (userTransferId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, coinName TEXT, transferAmt REAL, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Payments
      await db.execute("CREATE TABLE IF NOT EXISTS User_Payments (userPaymentId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, paymentMethod TEXT, paymentAmt REAL, paymentDate DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
    });
  }

  // User_Info
  Future<bool> login(String username, String password) async {
    final Database db = await open();
    var result = await db.rawQuery("SELECT * FROM User_Info WHERE username = '$username' AND userPassword = '$password' AND isActive = 1;");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getUser(String username) async {
    final Database db = await open();
    var result = await db.query("User_Info", where: "username = ?", whereArgs: [username]);
    return User.fromMap(result.first);
  }

  Future<int> insertUser(User user) async {
    final Database db = await open();
    return db.insert('User_Info', user.toMap());
  }

  Future<bool> checkUsername(String username) async {
    final Database db = await open();
    var result = await db.rawQuery("SELECT * FROM User_Info WHERE username = '$username';");
    if (result.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkEmail(String email) async {
    final Database db = await open();
    var result = await db.rawQuery("SELECT * FROM User_Info WHERE email = '$email';");
    if (result.isNotEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<List<User>> getUsers() async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.query('User_Info');
    return result.map((e) => User.fromMap(e)).toList();
  }
 
  Future<int> deleteUser(int? userId) async {
    final Database db = await open();
    return db.rawUpdate('UPDATE User_Info SET isActive = ? WHERE userId = ?', [0, userId]);
  }

  Future<int> changeEmail(String email, int? userId) async {
    final Database db = await open();
    return db.rawUpdate('UPDATE User_Info SET email = ? WHERE userId = ?', [email, userId]);
  }

  Future<int> changePassword(String password, int? userId) async {
    final Database db = await open();
    return db.rawUpdate('UPDATE User_Info SET userPassword = ? WHERE userId = ?', [password, userId]);
  }

  Future<int> changePhone(String phone, int? userId) async {
    final Database db = await open();
    return db.rawUpdate('UPDATE User_Info SET phoneNum = ? WHERE userId = ?', [phone, userId]);
  }

  // User_Activity
  Future<int> insertUserLoginDate(int? userId, String activityTimeStamp, String loginIP)async {
    final Database db = await open();
    return db.rawInsert("INSERT INTO User_Activity (userId, activityTimeStamp, ip_address) VALUES ($userId, '$activityTimeStamp', '$loginIP');");
  }

  Future<List<UserActivity>> getUserActivity(int? userId) async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.rawQuery("SELECT * FROM User_Activity WHERE userId = $userId");
    return result.map((e) => UserActivity.fromMap(e)).toList();
  }

  // Future<UserActivity> getUserActivity(int? userId) async {
  //   final Database db = await open();
  //   var result = await db.query("User_Activity", where: "userId = ?", whereArgs: [userId]);
  //   return UserActivity.fromMap(result.first);
  // }

  Future<List<UserActivity>> getUserActivities() async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.query('User_Activity');
    return result.map((e) => UserActivity.fromMap(e)).toList();
  }

}