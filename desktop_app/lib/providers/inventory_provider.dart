import 'package:flutter/foundation.dart';
import '../database/database_helper.dart';
import 'sales_provider.dart';

class Product {
  final int? id;
  final String name;
  final String description;
  final double price;
  final int quantity;
  final String category;

  Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      quantity: map['quantity'],
      category: map['category'],
    );
  }

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    int? quantity,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
    );
  }
}

class InventoryProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _searchQuery = '';

  List<Product> get products => _searchQuery.isEmpty ? [..._products] : [..._filteredProducts];

  InventoryProvider() {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final productMaps = await _dbHelper.getProducts();
    _products = productMaps.map((map) => Product.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final id = await _dbHelper.insertProduct(product.toMap());
    final newProduct = Product(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      quantity: product.quantity,
      category: product.category,
    );
    _products.add(newProduct);
    notifyListeners();
  }

  Future<void> updateProduct(Product product) async {
    await _dbHelper.updateProduct(product.toMap());
    final index = _products.indexWhere((p) => p.id == product.id);
    if (index >= 0) {
      _products[index] = product;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(int id) async {
    await _dbHelper.deleteProduct(id);
    _products.removeWhere((p) => p.id == id);
    notifyListeners();
  }

  Product? getProductById(int id) {
    try {
      return _products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> updateProductQuantities(List<SaleItem> items) async {
    // Update local products
    for (var item in items) {
      final productIndex = _products.indexWhere((p) => p.id == item.productId);
      if (productIndex != -1) {
        _products[productIndex] = _products[productIndex].copyWith(
          quantity: _products[productIndex].quantity - item.quantity,
        );
      }
    }
    notifyListeners();
  }

  Future<void> reloadProducts() async {
    await _loadProducts();
  }

  Future<List<Product>> getLowStockProducts(int threshold) async {
    final productMaps = await _dbHelper.getLowStockProducts(threshold);
    return productMaps.map((map) => Product.fromMap(map)).toList();
  }

  void searchProducts(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredProducts = [];
    } else {
      _filteredProducts = _products.where((product) =>
        product.name.toLowerCase().contains(query.toLowerCase()) ||
        product.category.toLowerCase().contains(query.toLowerCase()) ||
        product.description.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }
}
