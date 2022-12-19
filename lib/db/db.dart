import 'package:sqflite/sqflite.dart';

Future<Database> init() async {
  var databasesPath = await getDatabasesPath();
  String path = '${databasesPath}nelac.db';

  Database? db;
  db ??= await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(id INTEGER PRIMARY KEY, sender TEXT, receiver TEXT, type TEXT, amount REAL, charges REAL, date TEXT, paid INTEGER)
    ''');
    await db.execute('''
    CREATE TABLE loans(id INTEGER PRIMARY KEY, lender TEXT, amount REAL, date TEXT, paid INTEGER)
    ''');
    await db.execute('''
    CREATE TABLE earnings(id INTEGER PRIMARY KEY, total REAL, charges REAL, date TEXT)
    ''');
  });

  return db;
  // await db.close();
}
