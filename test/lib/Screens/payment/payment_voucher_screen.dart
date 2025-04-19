import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PaymentVoucherScreen extends StatefulWidget {
  const PaymentVoucherScreen({Key? key}) : super(key: key);

  @override
  State<PaymentVoucherScreen> createState() => _PaymentVoucherScreenState();
}

class _PaymentVoucherScreenState extends State<PaymentVoucherScreen> {
  final _formKey = GlobalKey<FormState>();
  final _items = <PaymentItem>[
    PaymentItem(
      sn: '01',
      className: 'Consultancy service',
      description: 'FARS',
      qty: 1,
      unitPrice: 1000000.00,
      vatPercentage: 7.50,
      whtPercentage: 2.5,
    ),
    PaymentItem(
      sn: '02',
      className: 'Consultancy service',
      description: 'Tax Service',
      qty: 1,
      unitPrice: 500000.00,
      vatPercentage: 7.50,
      whtPercentage: 10,
    ),
  ];

  String _accountName = '';
  String _accountNumber = '';
  String _bankName = '';
  String _subject = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Payment Voucher'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Voucher',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter subject',
                labelText: 'Subject',
              ),
              onChanged: (value) => _subject = value,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  const PaymentTableHeader(),
                  ...List.generate(_items.length, (index) {
                    final item = _items[index];
                    return PaymentTableRow(item: item);
                  }),
                  _buildAddButton(),
                  const Divider(height: 1),
                  PaymentTotalRow(items: _items),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[300]!,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: const Text(
                'Net amount in words:',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Beneficiary Payment Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter name',
                      labelText: 'Account name',
                    ),
                    onChanged: (value) => _accountName = value,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter number',
                      labelText: 'Account number',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _accountNumber = value,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Enter bank name',
                      labelText: 'Bank name',
                    ),
                    onChanged: (value) => _bankName = value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ElevatedButton.icon(
        onPressed: () {
          // Add new row logic here
        },
        icon: const Icon(Icons.add, size: 20),
        label: const Text('Add another row'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[600],
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  double _calculateNetTotal() {
    return _items.fold(0, (sum, item) => sum + item.netAmount);
  }

  String _convertToWords(double amount) {
    // This is a placeholder. You might want to use a proper number-to-words converter
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(amount) + " Naira";
  }
}

class PaymentTableHeader extends StatelessWidget {
  const PaymentTableHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _buildHeaderCell('S/N')),
          Expanded(flex: 2, child: _buildHeaderCell('Class')),
          Expanded(flex: 2, child: _buildHeaderCell('Description')),
          Expanded(flex: 1, child: _buildHeaderCell('QTY')),
          Expanded(flex: 2, child: _buildHeaderCell('Unit Price (₦)')),
          Expanded(flex: 2, child: _buildHeaderCell('Amount (₦)')),
          Expanded(flex: 1, child: _buildHeaderCell('VAT %')),
          Expanded(flex: 2, child: _buildHeaderCell('VAT Amount (₦)')),
          Expanded(flex: 2, child: _buildHeaderCell('Gross Amount (₦)')),
          Expanded(flex: 1, child: _buildHeaderCell('WHT%')),
          Expanded(flex: 2, child: _buildHeaderCell('WHT Amount')),
          Expanded(flex: 2, child: _buildHeaderCell('Net Amount')),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }
}

class PaymentTableRow extends StatelessWidget {
  final PaymentItem item;

  const PaymentTableRow({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[100]!)),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: _buildCell(item.sn)),
          Expanded(flex: 2, child: _buildCell(item.className)),
          Expanded(flex: 2, child: _buildCell(item.description)),
          Expanded(flex: 1, child: _buildCell(item.qty.toString())),
          Expanded(flex: 2, child: _buildCell(formatter.format(item.unitPrice))),
          Expanded(flex: 2, child: _buildCell(formatter.format(item.amount))),
          Expanded(flex: 1, child: _buildCell('${item.vatPercentage}%')),
          Expanded(flex: 2, child: _buildCell(formatter.format(item.vatAmount))),
          Expanded(flex: 2, child: _buildCell(formatter.format(item.grossAmount))),
          Expanded(flex: 1, child: _buildCell('${item.whtPercentage}%')),
          Expanded(flex: 2, child: _buildCell(formatter.format(item.whtAmount))),
          Expanded(flex: 2, child: _buildCell(formatter.format(item.netAmount))),
        ],
      ),
    );
  }

  Widget _buildCell(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.black87,
      ),
    );
  }
}

class PaymentTotalRow extends StatelessWidget {
  final List<PaymentItem> items;

  const PaymentTotalRow({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    
    double totalAmount = items.fold(0, (sum, item) => sum + item.amount);
    double totalVatAmount = items.fold(0, (sum, item) => sum + item.vatAmount);
    double totalWhtAmount = items.fold(0, (sum, item) => sum + item.whtAmount);
    double totalNetAmount = items.fold(0, (sum, item) => sum + item.netAmount);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Expanded(flex: 6, child: Text('Total', style: TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 2, child: Text(formatter.format(totalAmount), style: const TextStyle(fontWeight: FontWeight.w500))),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 2, child: Text(formatter.format(totalVatAmount), style: const TextStyle(fontWeight: FontWeight.w500))),
          const Expanded(flex: 2, child: SizedBox()),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 2, child: Text(formatter.format(totalWhtAmount), style: const TextStyle(fontWeight: FontWeight.w500))),
          Expanded(flex: 2, child: Text(formatter.format(totalNetAmount), style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class PaymentItem {
  final String sn;
  final String className;
  final String description;
  final int qty;
  final double unitPrice;
  final double vatPercentage;
  final double whtPercentage;

  PaymentItem({
    required this.sn,
    required this.className,
    required this.description,
    required this.qty,
    required this.unitPrice,
    required this.vatPercentage,
    required this.whtPercentage,
  });

  double get amount => qty * unitPrice;
  double get vatAmount => amount * (vatPercentage / 100);
  double get grossAmount => amount + vatAmount;
  double get whtAmount => amount * (whtPercentage / 100);
  double get netAmount => grossAmount - whtAmount;
}
