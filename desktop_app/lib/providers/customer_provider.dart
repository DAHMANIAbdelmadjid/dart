import 'package:flutter/foundation.dart';
import '../database/database_helper.dart';

class Customer {
  final int? id;
  final String name;
  final String phone;
  final String email;
  final String address;

  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      name: map['name'],
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
    );
  }
}

class CustomerProvider with ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Customer> _customers = [];
  List<Customer> _filteredCustomers = [];
  String _searchQuery = '';

  List<Customer> get customers => _searchQuery.isEmpty ? [..._customers] : [..._filteredCustomers];

  CustomerProvider() {
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    final customerMaps = await _dbHelper.getCustomers();
    _customers = customerMaps.map((map) => Customer.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addCustomer(Customer customer) async {
    final id = await _dbHelper.insertCustomer(customer.toMap());
    final newCustomer = Customer(
      id: id,
      name: customer.name,
      phone: customer.phone,
      email: customer.email,
      address: customer.address,
    );
    _customers.add(newCustomer);
    notifyListeners();
  }

  Future<void> updateCustomer(Customer customer) async {
    await _dbHelper.updateCustomer(customer.toMap());
    final index = _customers.indexWhere((c) => c.id == customer.id);
    if (index >= 0) {
      _customers[index] = customer;
      notifyListeners();
    }
  }

  Future<void> deleteCustomer(int id) async {
    await _dbHelper.deleteCustomer(id);
    _customers.removeWhere((c) => c.id == id);
    notifyListeners();
  }

  Customer? getCustomerById(int id) {
    try {
      return _customers.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  void searchCustomers(String query) {
    _searchQuery = query;
    if (query.isEmpty) {
      _filteredCustomers = [];
    } else {
      _filteredCustomers = _customers.where((customer) =>
        customer.name.toLowerCase().contains(query.toLowerCase()) ||
        customer.phone.contains(query) ||
        customer.email.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }
    notifyListeners();
  }
}
