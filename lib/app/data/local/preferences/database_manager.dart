import 'package:expense_tracker/app/data/local/preferences/local_db_model.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DataBaseManager {
  static DataBaseManager? _databaseHelper; // singletons class use one time
  static Database? _database;
  List<AuthUserModel> authUser = [];

  String tableName = 'user';
  String id = 'id';
  String name = 'name';
  String phoneNumber = 'phoneNumber';
  String email = 'email';
  String password = 'password';
  String isVerified = 'isVerified';

  String tableExpense = 'expense';
  String expenseId = 'expenseId';
  String expenseName = 'expenseName';
  String expenseDate = 'expenseDate';
  String category = 'category';
  String price = 'price';
  String notes = 'notes';
  String icon = 'icon';

  String authenticatedUser = 'authenticatedUser';
  String authenticatedUserID = 'authenticatedUserID';

  DataBaseManager._createInstance(); // Named Constructor to relate Instance of db

  factory DataBaseManager() {
    _databaseHelper ??= DataBaseManager._createInstance();
    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await intializeDatabase();
    return _database!;
  }

  Future<void> deleteDatabaseIfExists() async {
    String databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'my.db');
    await deleteDatabase(path);
  }

  Future<Database> intializeDatabase() async {
    // get directory patch for both android and ios to store DataBase
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'my.db');
    /* open / create the database given path*/
    var notesDatabase =
        await openDatabase(path, version: 2, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableName ($id INTEGER PRIMARY KEY AUTOINCREMENT, $name TEXT, '
        '$email TEXT UNIQUE, $phoneNumber TEXT UNIQUE, $password TEXT, $isVerified INTEGER DEFAULT 0)');

    await db.execute(
        'CREATE TABLE $tableExpense ($expenseId INTEGER PRIMARY KEY AUTOINCREMENT,$icon TEXT, '
            '$expenseDate TEXT, $category TEXT, $price TEXT, $notes TEXT, '
            '$id INTEGER, FOREIGN KEY ($id) REFERENCES $tableName($id))');

    await db.execute(
        'CREATE TABLE $authenticatedUser ($authenticatedUserID INTEGER)');
  }

  /*------------------------------------------------------ insert User Data -----------------------------------------------------*/

  Future<int> insertData({required Map<String, dynamic>? dataBody}) async {
    Database database = await this.database;
    String phoneNumber = dataBody!['phoneNumber'];
    String email = dataBody['email'];
    List<Map<String, dynamic>> existingRecords = await database.query(
      tableName,
      where: 'phoneNumber = ? OR email = ?',
      whereArgs: [phoneNumber, email],
    );
    if (existingRecords.isNotEmpty) {
      throw Exception('Phone number or email already exists in the database.');
    }
    try{
      var result = await database.insert(tableName, dataBody);
      return result;
    }catch (e) {
      throw Exception("$e");
    }
  }


/*------------------------------------------------------ insert Auth User Data -----------------------------------------------------*/

  Future<int> insertAuthData({required Map<String, dynamic>? dataBody}) async {
    Database database = await this.database;
    try{
      var result = await database.insert(authenticatedUser, dataBody!);
      return result;
    }catch (e) {
      throw Exception("$e");
    }
  }

/*------------------------------------------------------ insert expense Data -----------------------------------------------------*/

  Future<int> insertExpenseData({required Map<String, dynamic>? dataBody}) async {
    Database database = await this.database;
    try{
      var result = await database.insert(tableExpense, dataBody!);
      return result;
    }catch (e) {
      throw Exception("$e");
    }
  }


  /*---------------------------------------------- Sign In ---------------------------------------*/

  Future<UserModel?> signIn({required Map<String, dynamic>? dataBody}) async {
    String password = dataBody!['password'];
    String email = dataBody['email'];
    try {
      Database database = await DataBaseManager().database;
      List<Map<String, dynamic>> result = await database.query(
        tableName,
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );
      if (result.isNotEmpty) {
        return UserModel.fromJson(result.first);
      } else {
        throw Exception('Invalid credentials');
      }
    } catch (e) {
      throw Exception("Error signing in: $e");
    }
  }

  /*---------------------------------------------- get all User data from Local DataBase ---------------------------------------*/

  /* fetch all notes objects from database */
  Future<List<UserModel>> getUserData() async {
    try {
      Database database = await this.database;
      var result = await database.query(tableName);
      List<UserModel> users = [];
      for (var map in result) {
        users.add(UserModel.fromJson(map));
      }
      return users;
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }


  /* ---------------------------------------------get Auth User data-------------------------------------------- */

  Future<List<AuthUserModel>> getAuthUserData() async {
    try {
      Database database = await this.database;
      var result = await database.query(authenticatedUser);
      List<AuthUserModel> users = [];
      for (var map in result) {
        users.add(AuthUserModel.fromJson(map));
      }
      return users;
    } catch (e) {
      throw Exception("Error fetching user data: $e");
    }
  }

  /* ---------------------------------------------get expenses data-------------------------------------------- */

  Future<List<ExpensesModel>> getExpensesData() async {
    try {
      Database database = await this.database;
      var result = await database.query(tableExpense);
      List<ExpensesModel> expenses = [];
      for (var map in result) {
        expenses.add(ExpensesModel.fromJson(map));
      }
      return expenses;
    } catch (e) {
      throw Exception("Error expenses user data: $e");
    }
  }

  Future<List<ExpensesModel>> getYearlyExpensesData({required String? year}) async {
    try {
      Database database = await this.database;
      authUser = await this.getAuthUserData();
      var result = await database.query(tableExpense,
          where: "$expenseDate LIKE ? AND $id = ?",
          whereArgs: ['%-$year', authUser[0].authenticatedUserID],
          orderBy: "substr($expenseDate, 4, 2), substr($expenseDate, 1, 2) ASC");
      List<ExpensesModel> expenses = [];
      for (var map in result) {
        print(map);
        expenses.add(ExpensesModel.fromJson(map));
      }

      return expenses;
    } catch (e) {
      throw Exception("Error fetching yearly expenses data: $e");
    }
  }



  Future<List<ExpensesModel>> getMonthlyExpensesData({required int month, required int year}) async {
    try {
      Database database = await this.database;
      authUser = await this.getAuthUserData();

      String formattedMonth = month < 10 ? '0$month' : '$month';
      String searchDate = '$formattedMonth-$year';

      var result = await database.query(tableExpense,
          where: "$expenseDate LIKE ? AND $id = ?",
          whereArgs: ['%$searchDate%', authUser[0].authenticatedUserID]);

      List<ExpensesModel> expenses = [];
      for (var map in result) {
        expenses.add(ExpensesModel.fromJson(map));
      }
      return expenses;
    } catch (e) {
      throw Exception("Error fetching monthly expenses data: $e");
    }
  }


  Future<List<ExpensesModel>> getExpensesDataInRange({required String startDate, required String endDate}) async {
    try {
      Database database = await this.database;
      authUser = await this.getAuthUserData();

      var result = await database.query(tableExpense,
          where: "$expenseDate BETWEEN ? AND ? AND $id = ?",
          whereArgs: ['$startDate', '$endDate', authUser[0].authenticatedUserID]);

      List<ExpensesModel> expenses = [];
      for (var map in result) {
        expenses.add(ExpensesModel.fromJson(map));
      }
      return expenses;
    } catch (e) {
      throw Exception("Error fetching expenses data in range: $e");
    }
  }

  Future<List<ExpensesModel>> getExpensesDataForDate({required String date}) async {
    try {
      Database database = await this.database;
      authUser = await this.getAuthUserData();

      var result = await database.query(tableExpense,
          where: "$expenseDate = ? AND $id = ?",
          whereArgs: ['$date', authUser[0].authenticatedUserID]);

      List<ExpensesModel> expenses = [];
      for (var map in result) {
        expenses.add(ExpensesModel.fromJson(map));
      }
      return expenses;
    } catch (e) {
      throw Exception("Error fetching expenses data for date: $e");
    }
  }

  /*------------------------------------------------------------- delete expense--------------------------------------------------------- */

  Future<int> deleteExpense({int? pId}) async {
    try {
      Database database = await this.database;
      int result = await database.delete(
        tableExpense,
        where: '$expenseId = ?',
        whereArgs: [pId],
      );
      return result;
    } catch (e) {
      print("Error deleting expense: $e");
      return -1; // Return a default value or handle the error as needed
    }
  }

  /*------------------------------------------------------------- LogOut --------------------------------------------------------- */

  Future<int> logOut() async {
    try {
      Database database = await this.database;
      int result = await database.delete(
        authenticatedUser,
        where: '$authenticatedUserID = ?',
        whereArgs: [authUser[0].authenticatedUserID],
      );
      return result;
    } catch (e) {
      print("Error deleting expense: $e");
      return -1; // Return a default value or handle the error as needed
    }
  }

  /*------------------------------------------------------ update expense ----------------------------------------------------*/

  Future<int> updateExpenseData({required int id, required Map<String, dynamic> dataBody}) async {
    Database database = await this.database;
    try {
      var result = await database.update(tableExpense, dataBody, where: '$expenseId = ?', whereArgs: [id]);
      return result;
    } catch (e) {
      throw Exception("$e");
    }
  }

  /*------------------------------------------------------ update  ----------------------------------------------------*/

  /* Verify User*/
  Future<int> updateIsVerified(int id) async {
    try {
      Database database = await this.database;
      var result  = await database.update(
        tableName,
        {'isVerified': 1}, // Setting isVerified to 1 (true)
        where: 'id = ?',
        whereArgs: [id],
      );
      return result;
    } catch (e) {
      throw Exception("Error updating isVerified: $e");
    }
  }


  /* --------------------------------------------  Authenticated User ------------------------------------------------------------------*/

  /* delete  data*/

  Future deleteDb() async {
    Database database = await this.database;
    await database.delete(tableName);
  }

  Future deleteExpenseData() async {
    Database database = await this.database;
    await database.delete(tableExpense);
  }


  Future deleteAuthUser() async {
    Database database = await this.database;
    await database.delete(authenticatedUser);
  }
}
