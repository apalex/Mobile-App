import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto_app/Models/user_model.dart';

class DatabaseHelper {
  String databaseName = 'mintless.db';

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) => createDatabase(db),
      version: 1
    );
  }

  void createDatabase(Database db) {
    // User_Info Table
    db.execute("CREATE TABLE User_Info (userId INTEGER PRIMARY KEY AUTOINCREMENT, firstName TEXT NOT NULL, lastName TEXT NOT NULL, username TEXT NOT NULL UNIQUE, email TEXT NOT NULL UNIQUE, userPassword TEXT NOT NULL, phoneNum TEXT NOT NULL, createdOn DATETIME DEFAULT CURRENT_TIMESTAMP, isActive INTEGER DEFAULT 1);");
    // User_Address Table
    db.execute("CREATE TABLE User_Address (userId INTEGER PRIMARY KEY, address1 TEXT, address2 TEXT, country TEXT, province TEXT, city TEXT, zipCode TEXT, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
    // User Portfolio Table
    db.execute("CREATE TABLE User_Portfolio (userId INTEGER, overallBal REAL DEFAULT 0, fundingBal REAL DEFAULT 0, tradingBal REAL DEFAULT 0, marginBal REAL DEFAULT 0, futureBal REAL DEFAULT 0, botBal REAL DEFAULT 0, financeBal REAL DEFAULT 0, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
    // User Activity
    db.execute("CREATE TABLE User_Activity (userActivityId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, activityTimeStamp DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
    // User Transfers
    db.execute("CREATE TABLE User_Transfers (userTransferId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, coinName TEXT, transferAmt REAL, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
    // User Payments
    db.execute("CREATE TABLE User_Payments (userPaymentId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, paymentMethod TEXT, paymentAmt REAL, paymentDate DATETIME DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
  }

  // CRUD
  // Create
  Future<int> insertUser(User user) async {
    final Database db = await initDatabase();
    return db.insert('User_Info', user.toMap());
  }

  // Read
  Future<List<User>> searchUser() async {
    final Database db = await initDatabase();
    List<Map<String, Object?>> result = await db.query('User_Info');
    return result.map((e) => User.fromMap(e)).toList();
  }
 
  // Update
  Future<int> deleteUser(User user, int userId) async {
    final Database db = await initDatabase();
    return await db.update("User_Info", user.toMap(), where: 'userId = ?', whereArgs: [userId]);
  }

}