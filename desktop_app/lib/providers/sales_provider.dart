import 'package:desktop_app/providers/inventory_provider.dart';
import 'package:flutter/foundation.dart';
import '../database/database_helper.dart';

class SaleItem {
  final int? id;
  final int productId;
  final int quantity;
  final double price;

  SaleItem({
    this.id,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  double get total => quantity * price;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
    };
  }

  factory SaleItem.fromMap(Map<String, dynamic> map) {
    return SaleItem(
      id: map['id'],
      productId: map['product_id'],
      quantity: map['quantity'],
      price: map['price'],
    );
  }
}

class Sale {
  final int? id;
  final DateTime date;
  final List<SaleItem> items;
  final int? customerId;
  final String paymentMethod;
  final double total;

  Sale({
    this.id,
    required this.date,
    required this.items,
    this.customerId,
    required this.paymentMethod,
    required this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'customer_id': customerId,
      'payment_method': paymentMethod,
      'total': total,
    };
  }

  factory Sale.fromMap(Map<String, dynamic> map, List<SaleItem> items) {
    return Sale(
      id: map['id'],
      date: DateTime.parse(map['date']),
      items: items,
      customerId: map['customer_id'],
      paymentMethod: map['payment_method'],
      total: map['total'],
    );
  }
}

class SalesProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Sale> _sales = [];
  List<Sale> _filteredSales = [];
  String _searchQuery = '';

  List<Sale> get sales => _searchQuery.isEmpty ? [..._sales] : [..._filteredSales];

  SalesProvider() {
    _loadSales();
  }

  Future<void> _loadSales() async {
    final saleMaps = await _dbHelper.getSales();
    _sales = [];
    
    for (var saleMap in saleMaps) {
      final saleItems = await _dbHelper.getSaleItems(saleMap['id']);
      final items = saleItems.map((item) => SaleItem.fromMap(item)).toList();
      _sales.add(Sale.fromMap(saleMap, items));
    }
    
    notifyListeners();
  }

  Future<bool> addSale(Sale sale, InventoryProvider inventoryProvider) async {
    try {
      final saleMap = sale.toMap();
      final itemMaps = sale.items.map((item) => item.toMap()).toList();
      
      await _dbHelper.insertSale(saleMap, itemMaps);
      await _loadSales();  // Reload sales after successful addition
      
      // Update inventory quantities
      await inventoryProvider.updateProductQuantities(sale.items);
      
      notifyListeners();
      return true;
    } catch (e) {
      print('Error adding sale: $e');
      return false;
    }
  }

  Future<List<Sale>> getSalesByDateRange(DateTime start, DateTime end) async {
    final saleMaps = await _dbHelper.getSalesByDateRange(
      start.toIso8601String(),
      end.toIso8601String(),
    );
    
    List<Sale> sales = [];
    for (var saleMap in saleMaps) {
      final saleItems = await _dbHelper.getSaleItems(saleMap['id']);
      final items = saleItems.map((item) => SaleItem.fromMap(item)).toList();
      sales.add(Sale.fromMap(saleMap, items));
    }
    
    return sales;
  }

  double getTotalSales() {
    return _sales.fold(0, (sum, sale) => sum + sale.total);
  }

  List<Sale> getSalesByCustomer(int customerId) {
    return _sales.where((sale) => sale.customerId == customerId).toList();
  }

  Future<List<Map<String, dynamic>>> getTopProducts(DateTime start, DateTime end) async {
    return await _dbHelper.getTopProducts(
      start.toIso8601String(),
      end.toIso8601String(),
    );
  }

  void searchSales(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredSales = [];
    } else {
      _filteredSales = _sales.where((sale) {
        final dateStr = sale.date.toString().split('.')[0];
        final paymentStr = sale.paymentMethod.toLowerCase();
        final queryLower = query.toLowerCase();
        
        return dateStr.contains(queryLower) ||
               paymentStr.contains(queryLower) ||
               sale.total.toString().contains(queryLower);
      }).toList();
    }
    notifyListeners();
  }
}
