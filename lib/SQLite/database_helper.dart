import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto_app/Models/user_model.dart';

class DatabaseHelper {
  late Database db;
  String databaseName = 'mintless.db';

  Future open() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await _createDatabase(db, version);
      }
    );
  }

  static Future<void> _createDatabase(Database db, int version) async {
    try {
      // User_Info Table
      await db.execute("CREATE TABLE IF NOT EXISTS User_Info (userId INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT NOT NULL, lastName TEXT NOT NULL, username TEXT NOT NULL UNIQUE, email TEXT NOT NULL UNIQUE, userPassword TEXT NOT NULL, phoneNum TEXT NOT NULL, createdOn DATETIME DEFAULT CURRENT_TIMESTAMP, isActive INTEGER DEFAULT 1);");
      // User_Address Table
      await db.execute("CREATE TABLE IF NOT EXISTS User_Address (userId INTEGER PRIMARY KEY, address1 TEXT, address2 TEXT, country TEXT, province TEXT, city TEXT, zipCode TEXT, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Portfolio Table
      await db.execute("CREATE TABLE IF NOT EXISTS User_Portfolio (userId INTEGER, overallBal REAL DEFAULT 0, fundingBal REAL DEFAULT 0, tradingBal REAL DEFAULT 0, marginBal REAL DEFAULT 0, futureBal REAL DEFAULT 0, botBal REAL DEFAULT 0, financeBal REAL DEFAULT 0, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Activity
      await db.execute("CREATE TABLE IF NOT EXISTS User_Activity (userActivityId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, activityTimeStamp DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Transfers
      await db.execute("CREATE TABLE IF NOT EXISTS User_Transfers (userTransferId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, coinName TEXT, transferAmt REAL, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Payments
      await db.execute("CREATE TABLE IF NOT EXISTS User_Payments (userPaymentId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, paymentMethod TEXT, paymentAmt REAL, paymentDate DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
    } catch(e) {
      print('Error creating database: $e');
    }
  }

  // CRUD
  // Create
  Future<int> insertUser(User user) async {
    return db.insert('User_Info', user.toMap());
  }

  // Read
  Future<bool> checkUsername(String username) async {
    List<Map<String, dynamic>> result = await db.query(
      'User_Info',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (result.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<User>> searchUser() async {
    List<Map<String, Object?>> result = await db.query('User_Info');
    return result.map((e) => User.fromMap(e)).toList();
  }
 
  // Update
  Future<int> deleteUser(int userId) async {
    return db.rawUpdate('UPDATE User_Info SET isActive = ? WHERE userId = ?', [0, userId]);
  }

}