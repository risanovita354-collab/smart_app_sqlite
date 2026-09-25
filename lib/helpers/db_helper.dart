import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/product.dart'; // <-- Import file model yang benar
import '../models/cart_item.dart'; // <-- Import file model yang benar

class DBHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'smart_cart.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE products(
            id TEXT PRIMARY KEY,
            name TEXT,
            price REAL,
            description TEXT,
            imageUrl TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE cart_items(
            id TEXT PRIMARY KEY,
            productId TEXT,
            name TEXT,
            price REAL,
            quantity INTEGER,
            imageUrl TEXT
          )
        ''');
      },
    );
  }

  // --- CRUD PRODUCTS ---
  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db.insert('products', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }

  // --- CRUD CART ---
  Future<int> insertCartItem(CartItem item) async {
    final db = await database;
    return await db.insert('cart_items', item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart_items');
    return List.generate(maps.length, (i) => CartItem.fromMap(maps[i]));
  }

  Future<int> updateCartQuantity(String id, int quantity) async {
    final db = await database;
    return await db.update(
      'cart_items',
      {'quantity': quantity},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCartItem(String id) async {
    final db = await database;
    return await db.delete('cart_items', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> clearCart() async {
    final db = await database;
    return await db.delete('cart_items');
  }
}