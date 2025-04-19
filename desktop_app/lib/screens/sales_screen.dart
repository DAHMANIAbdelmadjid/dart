import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/sales_provider.dart';
import '../providers/inventory_provider.dart';
import '../providers/customer_provider.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final salesProvider = context.watch<SalesProvider>();
    final sales = salesProvider.sales;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sales Management',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showNewSaleDialog(context),
                icon: const Icon(Icons.add),
                label: const Text('New Sale'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search Sales',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              hintText: 'Search by date, payment method, or total amount',
            ),
            onChanged: (value) {
              salesProvider.searchSales(value);
            },
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Card(
              child: ListView.builder(
                itemCount: sales.length,
                itemBuilder: (context, index) {
                  final sale = sales[index];
                  final customer = sale.customerId != null
                      ? context
                          .read<CustomerProvider>()
                          .getCustomerById(sale.customerId!)
                      : null;

                  return ExpansionTile(
                    title: Text('Sale #${sale.id}'),
                    subtitle:
                        Text('Date: ${sale.date.toString().split('.')[0]}'),
                    trailing: Text(
                      'DZD${sale.total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (customer != null)
                              Text('Customer: ${customer.name}')
                            else
                              const Text('Customer: Walk-in Customer'),
                            Text('Payment Method: ${sale.paymentMethod}'),
                            const Divider(),
                            const Text(
                              'Items:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            ...sale.items.map((item) {
                              final product = context
                                  .read<InventoryProvider>()
                                  .getProductById(item.productId);
                              return ListTile(
                                title: Text(product?.name ?? 'Unknown Product'),
                                subtitle: Text('Quantity: ${item.quantity}'),
                                trailing:
                                    Text('DZD${item.total.toStringAsFixed(2)}'),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNewSaleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('New Sale'),
        content: SizedBox(
          width: 600,
          child: _NewSaleForm(),
        ),
      ),
    );
  }
}

class _NewSaleForm extends StatefulWidget {
  const _NewSaleForm();

  @override
  _NewSaleFormState createState() => _NewSaleFormState();
}

class _NewSaleFormState extends State<_NewSaleForm> {
  final List<SaleItem> _items = [];
  Customer? _selectedCustomer;
  String _paymentMethod = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Optional customer selection
        DropdownButtonFormField<Customer?>(
          value: _selectedCustomer,
          items: [
            const DropdownMenuItem<Customer?>(
              value: null,
              child: Text('Walk-in Customer'),
            ),
            ...context.read<CustomerProvider>().customers.map((customer) {
              return DropdownMenuItem(
                value: customer,
                child: Text(customer.name),
              );
            }).toList(),
          ],
          onChanged: (value) {
            setState(() {
              _selectedCustomer = value;
            });
          },
          decoration: const InputDecoration(labelText: 'Customer (Optional)'),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _paymentMethod,
          items: ['Cash', 'Credit Card', 'Debit Card'].map((method) {
            return DropdownMenuItem(
              value: method,
              child: Text(method),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _paymentMethod = value!;
            });
          },
          decoration: const InputDecoration(labelText: 'Payment Method'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => _showAddItemDialog(context),
          child: const Text('Add Item'),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              final item = _items[index];
              final product = context
                  .read<InventoryProvider>()
                  .getProductById(item.productId);
              return ListTile(
                title: Text(product?.name ?? 'Unknown Product'),
                subtitle: Text('Quantity: ${item.quantity}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      _items.removeAt(index);
                    });
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _submitSale,
              child: const Text('Complete Sale'),
            ),
          ],
        ),
      ],
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Item'),
        content: _AddItemForm(
          onItemAdded: (item) {
            setState(() {
              _items.add(item);
            });
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _submitSale() async {
    setState(() {
      _items.sort((a, b) => a.productId.compareTo(b.productId));
    });

    if (_items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add items to the sale'),
        ),
      );
      return;
    }

    final double total = _items.fold(
      0,
      (sum, item) => sum + (item.quantity * item.price),
    );

    final sale = Sale(
      date: DateTime.now(),
      items: _items,
      customerId: _selectedCustomer?.id,
      paymentMethod: _paymentMethod,
      total: total,
    );

    final success = await context.read<SalesProvider>().addSale(
          sale,
          context.read<InventoryProvider>(),
        );

    if (success) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to create sale. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class _AddItemForm extends StatefulWidget {
  final Function(SaleItem) onItemAdded;

  const _AddItemForm({required this.onItemAdded});

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<_AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  Product? _selectedProduct;
  final _quantityController = TextEditingController();

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final inventoryProvider = context.watch<InventoryProvider>();
    final products =
        inventoryProvider.products.where((p) => p.quantity > 0).toList();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (products.isEmpty)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'No products available in stock',
                style: TextStyle(color: Colors.red),
              ),
            )
          else
            DropdownButtonFormField<Product>(
              value: _selectedProduct,
              items: products.map((product) {
                return DropdownMenuItem(
                  value: product,
                  child:
                      Text('${product.name} (In Stock: ${product.quantity})'),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedProduct = value;
                  // Reset quantity when product changes
                  _quantityController.clear();
                });
              },
              decoration: const InputDecoration(labelText: 'Product'),
            ),
          TextFormField(
            controller: _quantityController,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a quantity';
              }
              final quantity = int.tryParse(value);
              if (quantity == null) {
                return 'Please enter a valid number';
              }
              if (quantity <= 0) {
                return 'Quantity must be greater than 0';
              }
              if (_selectedProduct != null &&
                  quantity > _selectedProduct!.quantity) {
                return 'Not enough stock available (${_selectedProduct!.quantity} available)';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: products.isEmpty ? null : _submitForm,
                child: const Text('Add'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedProduct != null) {
      final quantity = int.parse(_quantityController.text);

      // Check stock availability again before submitting
      if (quantity <= _selectedProduct!.quantity) {
        final item = SaleItem(
          productId: _selectedProduct!.id!,
          quantity: quantity,
          price: _selectedProduct!.price,
        );
        widget.onItemAdded(item);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Not enough stock available (${_selectedProduct!.quantity} available)'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
