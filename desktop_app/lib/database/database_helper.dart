import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'hardware_shop.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Products table
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        quantity INTEGER NOT NULL,
        category TEXT NOT NULL
      )
    ''');

    // Customers table
    await db.execute('''
      CREATE TABLE customers(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT,
        phone TEXT,
        address TEXT
      )
    ''');

    // Sales table
    await db.execute('''
      CREATE TABLE sales(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_id INTEGER NULL,
        date TEXT NOT NULL,
        payment_method TEXT NOT NULL,
        total REAL NOT NULL,
        FOREIGN KEY (customer_id) REFERENCES customers (id)
      )
    ''');

    // Sale items table
    await db.execute('''
      CREATE TABLE sale_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        sale_id INTEGER,
        product_id INTEGER,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        FOREIGN KEY (sale_id) REFERENCES sales (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');
  }

  // Product operations
  Future<int> insertProduct(Map<String, dynamic> product) async {
    Database db = await database;
    return await db.insert('products', product);
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    Database db = await database;
    return await db.query('products');
  }

  Future<int> updateProduct(Map<String, dynamic> product) async {
    Database db = await database;
    return await db.update(
      'products',
      product,
      where: 'id = ?',
      whereArgs: [product['id']],
    );
  }

  Future<int> deleteProduct(int id) async {
    Database db = await database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Customer operations
  Future<int> insertCustomer(Map<String, dynamic> customer) async {
    Database db = await database;
    return await db.insert('customers', customer);
  }

  Future<List<Map<String, dynamic>>> getCustomers() async {
    Database db = await database;
    return await db.query('customers');
  }

  Future<int> updateCustomer(Map<String, dynamic> customer) async {
    Database db = await database;
    return await db.update(
      'customers',
      customer,
      where: 'id = ?',
      whereArgs: [customer['id']],
    );
  }

  Future<int> deleteCustomer(int id) async {
    Database db = await database;
    return await db.delete(
      'customers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Sale operations
  Future<int> insertSale(Map<String, dynamic> sale, List<Map<String, dynamic>> items) async {
    Database db = await database;
    return await db.transaction((txn) async {
      // First, verify stock availability for all items
      for (var item in items) {
        final product = await txn.query(
          'products',
          where: 'id = ?',
          whereArgs: [item['product_id']],
        );
        
        if (product.isEmpty) {
          throw Exception('Product not found');
        }
        
        final currentStock = product.first['quantity'] as int;
        if (currentStock < item['quantity']) {
          throw Exception('Not enough stock for product ${product.first['name']}');
        }
      }

      // Insert the sale
      final saleId = await txn.insert('sales', sale);
      
      // Process each item
      for (var item in items) {
        item['sale_id'] = saleId;
        await txn.insert('sale_items', item);
        
        // Update product quantity
        await txn.rawUpdate('''
          UPDATE products 
          SET quantity = quantity - ? 
          WHERE id = ?
        ''', [item['quantity'], item['product_id']]);
      }
      
      return saleId;
    });
  }

  Future<List<Map<String, dynamic>>> getSales() async {
    Database db = await database;
    return await db.query('sales', orderBy: 'date DESC');
  }

  Future<List<Map<String, dynamic>>> getSaleItems(int saleId) async {
    Database db = await database;
    return await db.query(
      'sale_items',
      where: 'sale_id = ?',
      whereArgs: [saleId],
    );
  }

  // Reports
  Future<List<Map<String, dynamic>>> getSalesByDateRange(String startDate, String endDate) async {
    Database db = await database;
    return await db.query(
      'sales',
      where: 'date BETWEEN ? AND ?',
      whereArgs: [startDate, endDate],
    );
  }

  Future<List<Map<String, dynamic>>> getTopProducts(String startDate, String endDate) async {
    Database db = await database;
    return await db.rawQuery('''
      SELECT 
        p.id,
        p.name,
        SUM(si.quantity) as total_quantity,
        SUM(si.quantity * si.price) as total_sales
      FROM products p
      JOIN sale_items si ON p.id = si.product_id
      JOIN sales s ON si.sale_id = s.id
      WHERE s.date BETWEEN ? AND ?
      GROUP BY p.id, p.name
      ORDER BY total_quantity DESC
      LIMIT 10
    ''', [startDate, endDate]);
  }

  Future<List<Map<String, dynamic>>> getLowStockProducts(int threshold) async {
    Database db = await database;
    return await db.query(
      'products',
      where: 'quantity <= ?',
      whereArgs: [threshold],
    );
  }
}
