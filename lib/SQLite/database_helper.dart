import 'package:crypto_app/Models/portfolio_model.dart';
import 'package:crypto_app/Models/user_activity_model.dart';
import 'package:crypto_app/Models/user_address_model.dart';
import 'package:crypto_app/Models/user_balance_model.dart';
import 'package:crypto_app/Models/user_payment_model.dart';
import 'package:crypto_app/Models/user_transfers.dart';
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
      await db.execute("CREATE TABLE IF NOT EXISTS User_Address (userAddressId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, address1 TEXT, address2 TEXT, country TEXT, province TEXT, city TEXT, zipCode TEXT, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Balance
      await db.execute("CREATE TABLE IF NOT EXISTS User_Balance (userId INTEGER PRIMARY KEY, userBalance REAL, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Portfolio
      await db.execute("CREATE TABLE IF NOT EXISTS User_Portfolio (userPortfolioId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, coinName TEXT, coinAmt REAL, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Activity
      await db.execute("CREATE TABLE IF NOT EXISTS User_Activity (userActivityId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, activityTimeStamp TEXT DEFAULT CURRENT_TIMESTAMP, ipAddress TEXT, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Transfers
      await db.execute("CREATE TABLE IF NOT EXISTS User_Transfers (userTransferId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, coinName TEXT, transferAmt REAL, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
      // User Payments
      await db.execute("CREATE TABLE IF NOT EXISTS User_Payments (userPaymentId INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, paymentMethod TEXT, paymentAmt REAL, paymentDate TEXT DEFAULT CURRENT_TIMESTAMP, action TEXT, FOREIGN KEY (userId) REFERENCES User_Info(userId));");
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

  Future<int?> getUserCount() async {
    final Database db = await open();
    var response = await db.rawQuery("SELECT COUNT(*) FROM User_Info;");
    int? count = Sqflite.firstIntValue(response);
    return count;
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
  Future<int> insertUserLoginDate(int? userId, String activityTimeStamp, String ipAddress)async {
    final Database db = await open();
    return db.rawInsert("INSERT INTO User_Activity (userId, activityTimeStamp, ipAddress) VALUES ($userId, '$activityTimeStamp', '$ipAddress');");
  }

  Future<List<UserActivity>> getUserActivity(int? userId) async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.rawQuery("SELECT * FROM User_Activity WHERE userId = $userId ORDER BY activityTimeStamp DESC;");
    return result.map((e) => UserActivity.fromMap(e)).toList();
  }

  Future<List<UserActivity>> getUserActivities() async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.query('User_Activity');
    return result.map((e) => UserActivity.fromMap(e)).toList();
  }

  // Portfolio
  Future<int> insertNewCoinPortfolio(PortfolioModel portfolio) async {
    final Database db = await open();
    return db.insert('User_Portfolio', portfolio.toMap());
  }

  Future<int> editCoinPortfolio(int? userId, String coinName, double coinAmt) async {
    final Database db = await open();
    return db.rawUpdate('UPDATE User_Portfolio SET coinAmt = ? WHERE userId = ? AND coinName = ?', [coinAmt, userId, coinName]);
  }

  Future<bool> isCoinOwned(int? userId, String coinName) async {
    final Database db = await open();
    var result = await db.rawQuery("SELECT * FROM User_Portfolio WHERE coinName = '$coinName' AND userId = $userId;");
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<PortfolioModel> getCoinAmt(int? userId, String coinName) async {
    final Database db = await open();
    var result = await db.rawQuery("SELECT * FROM User_Portfolio WHERE userId = $userId AND coinName = '$coinName';");
    return PortfolioModel.fromMap(result.first);
  }

  Future<List<PortfolioModel>> getAllPortfolios() async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.query('User_Portfolio');
    return result.map((e) => PortfolioModel.fromMap(e)).toList();
  }

  Future<List<PortfolioModel>> getPortolio(int? userId) async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.query("User_Portfolio", where: "userId = ?", whereArgs: [userId]);
    return result.map((e) => PortfolioModel.fromMap(e)).toList();
  }

  // User Address
    Future<int> insertUserAddress(UserAddress address) async {
    final Database db = await open();
    return db.insert('User_Address', address.toMap());
  }

  Future<List<UserAddress>> getUserAddresses() async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.query('User_Address');
    return result.map((e) => UserAddress.fromMap(e)).toList();
  }

  // User Payments
    Future<int> insertUserPayment(UserPayment receipt) async {
    final Database db = await open();
    return db.insert('User_Payments', receipt.toMap());
  }

  Future<List<UserPayment>> getAllPayments() async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.query('User_Payments');
    return result.map((e) => UserPayment.fromMap(e)).toList();
  }

  Future<List<UserPayment>> getUserPayments(int? userId) async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.rawQuery("SELECT * FROM User_Payments WHERE userId = $userId ORDER BY paymentDate DESC;");
    return result.map((e) => UserPayment.fromMap(e)).toList();
  }

  // User Transfers
  Future<int> insertUserTransfer(UserTransfers userTransfer) async {
    final Database db = await open();
    return db.insert('User_Transfers', userTransfer.toMap());
  }

  // User Balance
  Future<int> createBalance(UserBalance userBalance) async {
    final Database db = await open();
    return db.insert('User_Balance', userBalance.toMap());
  }

  Future<List<UserBalance>> getAllBalances() async {
    final Database db = await open();
    List<Map<String, Object?>> result = await db.query('User_Balance');
    return result.map((e) => UserBalance.fromMap(e)).toList();
  }

  Future<UserBalance> getUserBalance(int? userId) async {
    final Database db = await open();
    var result = await db.query("User_Balance", where: "userId = ?", whereArgs: [userId]);
    return UserBalance.fromMap(result.first);
  }

  Future<int> insertDepositBalance(int? userId, double deposit) async {
    final Database db = await open();
    return db.rawUpdate('UPDATE User_Balance SET userBalance = ? WHERE userId = ?', [deposit, userId]);
  }

}