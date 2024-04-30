import 'dart:async';

import 'package:farmrecords/modal.dart';
import 'package:farmrecords/services/auth.dart';
import 'package:sqflite/sqflite.dart';
class StorageService {
  static final StorageService instance = StorageService.init();
  final _cattleController = StreamController<List<Catttle>>.broadcast();

  static Database? _database;

  StorageService.init() {
    // Call fetchCattle when the service is initialized
    fetchCattle();
  }

  Stream<List<Catttle>> get cattleStream => _cattleController.stream;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB('data.db');
    return _database!;
  }

  Future<void> fetchCattle() async {
    final db = await database;
    while (true) {
      try {
        final List<Map<String, dynamic>> maps = await db.query('cattle');
        final cattleList = List.generate(maps.length, (i) {
          return Catttle(
            id: maps[i]['id'],
            cattleId: maps[i]['cattleId'],
            type: maps[i]['type'],
            purpose: maps[i]['purpose'],
          );
        });
        // Add the cattle list to the stream
        _cattleController.sink.add(cattleList);
        // Add a delay to simulate periodic checks (replace with actual watch method)
        await Future.delayed(const Duration(seconds: 5)); // Adjust delay as needed
      } catch (e) {
        print('Error getting cattle: $e');
        throw Exception('Failed to get cattle data');
      }
    }
  }


  Future<Database> initDB(String filePath) async {
    final dpath = await getDatabasesPath();
    final path = '$dpath/$filePath';
    return await openDatabase(path, version: 3, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    await db.execute('''
CREATE TABLE users(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT,
  email TEXT,
  password TEXT,
  location TEXT,
  phone VARCHAR(10),
  gender TEXT,
  farmName TEXT
);
''');

    await db.execute('''
CREATE TABLE cattle(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TIMESTAMP,
  cattleId TEXT,
  type TEXT,
  purpose TEXT,
  userId INTEGER,
  FOREIGN KEY (userId) REFERENCES users(id)
);
''');

    await db.execute('''
CREATE TABLE diseased(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  date TIMESTAMP,
  cattleId TEXT,
  disease TEXT,
  medication TEXT,
  times INT,
  userId INTEGER,
  FOREIGN KEY (userId) REFERENCES users(id)
);
''');

    await db.execute('''
CREATE TABLE milk (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cowId TEXT,
  date TIMESTAMP,
  liters INT,
  time TEXT,  
  userId INTEGER,
  FOREIGN KEY (userId) REFERENCES users(id)
);
''');

    await db.execute('''
CREATE TABLE feedings(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  sacks INT,
  date TIMESTAMP,
  userId INTEGER,
  FOREIGN KEY (userId) REFERENCES users(id)
);
''');

    await db.execute('''
CREATE TABLE expenses(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  item TEXT,
  amount INT,
  date TIMESTAMP,
  userId INTEGER,
  FOREIGN KEY (userId) REFERENCES users(id)
);
''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
        password: maps[i]['password'],
        location: maps[i]['location'],
        phone: maps[i]['phone'],
        gender: maps[i]['gender'],
        farmName: maps[i]['farmName'],
      );
    });
  }

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> getCattleCountForPurpose(String purpose) async {
    final db = await instance.database;
    try {
      final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT COUNT(*) as count FROM cattle WHERE purpose = ?
    ''', [purpose]);
      return result.isNotEmpty ? result.first['count'] : 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<int> getAllCattleCount() async {
    final db = await instance.database;
    try {
      final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT COUNT(*) as count FROM cattle
    ''');
      return result.isNotEmpty ? result.first['count'] : 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  Future<void> insertCattle(
      String cattleId, String type, String purpose) async {
    try {
      final db = await database;
      await db.insert(
        'cattle',
        {
          'date': DateTime.now()
              .toIso8601String(), // Assuming you want to insert the current date
          'cattleId': cattleId,
          'type': type,
          'purpose': purpose,
          'userId': AuthService()
              .getCurrentUser()
              ?.id, // Assuming you have a current user object with an id field
        },
        conflictAlgorithm: ConflictAlgorithm
            .replace, // Handle conflicts by replacing existing data
      );
      print('Cattle data inserted successfully');
    } catch (e) {
      print('Error inserting cattle data: $e');
      throw Exception('Failed to insert cattle data');
    }
  }

  Future<List<Catttle>>? getAllCattle() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('cattle');
      return List.generate(maps.length, (i) {
        return Catttle(
          id: maps[i]['id'],
          cattleId: maps[i]['cattleId'],
          type: maps[i]['type'],
          purpose: maps[i]['purpose'],
        );
      });
    } catch (e) {
      print('Error getting all cattle: $e');
      throw Exception('Failed to get cattle data');
    }
  }


  Future<void> insertDiseased(Diseased diseased) async {
    final db = await database;
    try {
      await db.insert(
        'diseased', // Table name
        diseased.toMap(), // Convert Diseased object to map
        conflictAlgorithm:
            ConflictAlgorithm.replace, // Replace data if conflict occurs
      );
      print('Inserted');
    } catch (e) {
      print(e);
    }
  }

  Future<List<Diseased>> getAllDiseased() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('diseased');
    return List.generate(maps.length, (i) {
      return Diseased(
        id: maps[i]['id'],
        date: DateTime.parse(maps[i]['date']),
        cattleId: maps[i]['cattleId'],
        disease: maps[i]['disease'],
        medication: maps[i]['medication'],
        times: maps[i]['times'],
        userId: maps[i]['userId'],
      );
    });
  }

  Future<void> insertMilk(Milk milk) async {
    final db = await database;
    await db.insert(
      'milk',
      milk.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //  print('Inserted milk with ID: $insertedId');
    print('Executed SQL: ${db.toString()}'); // Log the executed SQL statement
    print('Milk data map: ${milk.toMap()}');
    print('Inserted');
  }

  Future<void> insertFeeding(Feeding feeding) async {
    await _database?.insert(
      'feedings',
      feeding.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertExpense(Expense expense) async {
    await _database?.insert(
      'expenses',
      expense.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, List<Map<String, dynamic>>>> getAllData() async {
    final Map<String, List<Map<String, dynamic>>> allData = {};
    final List<String> tables = [
      'users',
      'cattle',
      'diseased',
      'milk',
      'feedings',
      'expenses'
    ];

    for (final table in tables) {
      allData[table] = (await _database?.query(table))!;
    }

    return allData;
  }

  Future<List<Milk>> getAllMilks() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('milk');
      return List.generate(maps.length, (i) {
        return Milk.fromMap(maps[i]);
      });
    } catch (e) {
      print('Error getting all milks: $e');
      throw Exception('Failed to get milk data');
    }
  }

  Future<int> getTotalMilkLiters() async {
    final List<Milk> milks =
        await getAllMilks(); // Assuming you have a method to retrieve all milk data
    int totalLiters = 0;
    for (Milk milk in milks) {
      totalLiters += milk.liters;
    }
    return totalLiters;
  }

   void dispose() {
    _cattleController.close();
  }
}
