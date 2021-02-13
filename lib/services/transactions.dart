import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/transactions.dart';

class TransactionsService {
  Future<Database> database;
  // WidgetsFlutterBinding.ensureInitialized();
  
  Future<Database> init() async {    
    database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), 'transactions_database.db'),
      // When the database is first created, create a table to store transactions.
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE transactions(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, amount INTEGER, type TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );

    return database;
  }

  Future<void> insert(Transactions transaction) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the transaction into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same transaction is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Transactions>> list() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The transactions.
    final List<Map<String, dynamic>> maps = await db.query('transactions');

    // Convert the List<Map<String, dynamic> into a List<transaction>.
    return List.generate(maps.length, (i) {
      return Transactions(
        id: maps[i]['id'],
        name: maps[i]['name'],
        amount: maps[i]['amount'],
        type: maps[i]['type'],
      );
    });
  }

  Future<void> update(Transactions transaction) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given transaction.
    await db.update(
      'transactions',
      transaction.toMap(),
      // Ensure that the transaction has a matching id.
      where: "id = ?",
      // Pass the transaction's id as a whereArg to prevent SQL injection.
      whereArgs: [transaction.id],
    );
  }

  Future<void> delete(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the transaction from the database.
    await db.delete(
      'transactions',
      // Use a `where` clause to delete a specific transaction.
      where: "id = ?",
      // Pass the transaction's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> clear() async {
    // Get a reference to the database.
    final db = await database;

    // Remove the transaction from the database.
    await db.delete('transactions');
  }
}