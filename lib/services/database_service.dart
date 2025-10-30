import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction.dart' as app_models;
import '../models/category.dart';

class DatabaseService {
  static Database? _database;
  static const String _databaseName = 'barebudget.db';
  static const int _databaseVersion = 2;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        type TEXT NOT NULL,
        date INTEGER NOT NULL,
        description TEXT,
        currency TEXT DEFAULT 'INR',
        isRecurring INTEGER DEFAULT 0,
        recurringType TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE categories(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        iconName TEXT NOT NULL,
        colorHex TEXT NOT NULL,
        type TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE settings(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT UNIQUE NOT NULL,
        value TEXT NOT NULL
      )
    ''');

    // Insert default settings
    await db.insert('settings', {'key': 'default_currency', 'value': 'INR'});

    // Insert default categories
    for (var category in DefaultCategories.expenseCategories) {
      await db.insert('categories', category.toMap());
    }
    for (var category in DefaultCategories.incomeCategories) {
      await db.insert('categories', category.toMap());
    }
  }

  static Future<void> _onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // Add settings table
      await db.execute('''
        CREATE TABLE settings(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          key TEXT UNIQUE NOT NULL,
          value TEXT NOT NULL
        )
      ''');

      // Insert default settings
      await db.insert('settings', {'key': 'default_currency', 'value': 'INR'});

      // Update existing transactions to use INR as default currency if they have USD
      await db.execute('''
        UPDATE transactions 
        SET currency = 'INR' 
        WHERE currency = 'USD' OR currency IS NULL
      ''');
    }
  }

  // Transaction operations
  static Future<int> insertTransaction(
    app_models.Transaction transaction,
  ) async {
    final db = await database;
    return await db.insert('transactions', transaction.toMap());
  }

  static Future<List<app_models.Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      orderBy: 'date DESC',
    );
    return List.generate(
      maps.length,
      (i) => app_models.Transaction.fromMap(maps[i]),
    );
  }

  static Future<List<app_models.Transaction>> getTransactionsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'transactions',
      where: 'date >= ? AND date <= ?',
      whereArgs: [start.millisecondsSinceEpoch, end.millisecondsSinceEpoch],
      orderBy: 'date DESC',
    );
    return List.generate(
      maps.length,
      (i) => app_models.Transaction.fromMap(maps[i]),
    );
  }

  static Future<void> updateTransaction(
    app_models.Transaction transaction,
  ) async {
    final db = await database;
    await db.update(
      'transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id],
    );
  }

  static Future<void> deleteTransaction(int id) async {
    final db = await database;
    await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  // Category operations
  static Future<int> insertCategory(Category category) async {
    final db = await database;
    return await db.insert('categories', category.toMap());
  }

  static Future<List<Category>> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return List.generate(maps.length, (i) => Category.fromMap(maps[i]));
  }

  static Future<List<Category>> getCategoriesByType(String type) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'categories',
      where: 'type = ?',
      whereArgs: [type],
    );
    return List.generate(maps.length, (i) => Category.fromMap(maps[i]));
  }

  static Future<void> updateCategory(Category category) async {
    final db = await database;
    await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  static Future<void> deleteCategory(int id) async {
    final db = await database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }

  // Settings operations
  static Future<String?> getSetting(String key) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
    );
    if (maps.isNotEmpty) {
      return maps.first['value'] as String;
    }
    return null;
  }

  static Future<void> setSetting(String key, String value) async {
    final db = await database;
    await db.insert('settings', {
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<String> getDefaultCurrency() async {
    final currency = await getSetting('default_currency');
    return currency ?? 'INR';
  }

  static Future<void> setDefaultCurrency(String currency) async {
    await setSetting('default_currency', currency);
  }

  // Clear all data
  static Future<void> clearAllData() async {
    final db = await database;

    // Delete all transactions
    await db.delete('transactions');

    // Delete all categories
    await db.delete('categories');

    // Re-insert default categories
    for (var category in DefaultCategories.expenseCategories) {
      await db.insert('categories', category.toMap());
    }
    for (var category in DefaultCategories.incomeCategories) {
      await db.insert('categories', category.toMap());
    }
  }
}
