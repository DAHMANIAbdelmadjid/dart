import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';

class Payment extends StatefulWidget {
  final double amount;

  const Payment({super.key, this.amount = 120.00});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  bool _isCardPayment = true;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          'Payment',
          style: getBoldStyle(
            fontSize: FontSize.s24,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // Amount display
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
            child: Center(
              child: Text(
                '\$${widget.amount.toStringAsFixed(2)}',
                style: getBoldStyle(
                  fontSize: FontSize.s40,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Payment form
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSize.s30),
                  topRight: Radius.circular(AppSize.s30),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppPadding.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Doctor Chanaling Payment Method',
                      style: getSemiBoldStyle(
                        fontSize: FontSize.s18,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    // Payment method selection
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isCardPayment = true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isCardPayment
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade200,
                              foregroundColor: _isCardPayment
                                  ? Colors.white
                                  : AppColors.textPrimaryColor,
                              elevation: _isCardPayment ? 2 : 0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p12),
                            ),
                            child: Text('Card Payment'),
                          ),
                        ),
                        const SizedBox(width: AppSize.s16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isCardPayment = false;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !_isCardPayment
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade200,
                              foregroundColor: !_isCardPayment
                                  ? Colors.white
                                  : AppColors.textPrimaryColor,
                              elevation: !_isCardPayment ? 2 : 0,
                              padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p12),
                            ),
                            child: Text('Cash Payment'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSize.s24),
                    // Card payment form
                    if (_isCardPayment) ...[
                      // Card Number
                      Text(
                        'Card Number',
                        style: getSemiBoldStyle(
                          fontSize: FontSize.s16,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: AppSize.s8),
                      TextFormField(
                        controller: _cardNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: '1234 5678 9012 3456',
                          hintStyle: getRegularStyle(
                            fontSize: FontSize.s16,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSize.s16),
                      // Expiry Date and CVV
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Expiry Date',
                                  style: getSemiBoldStyle(
                                    fontSize: FontSize.s16,
                                    color: AppColors.textPrimaryColor,
                                  ),
                                ),
                                const SizedBox(height: AppSize.s8),
                                TextFormField(
                                  controller: _expiryDateController,
                                  keyboardType: TextInputType.datetime,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s8),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: 'MM/YY',
                                    hintStyle: getRegularStyle(
                                      fontSize: FontSize.s16,
                                      color: AppColors.textSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppSize.s16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'CVV',
                                  style: getSemiBoldStyle(
                                    fontSize: FontSize.s16,
                                    color: AppColors.textPrimaryColor,
                                  ),
                                ),
                                const SizedBox(height: AppSize.s8),
                                TextFormField(
                                  controller: _cvvController,
                                  keyboardType: TextInputType.number,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade100,
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(AppSize.s8),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: '123',
                                    hintStyle: getRegularStyle(
                                      fontSize: FontSize.s16,
                                      color: AppColors.textSecondaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSize.s16),
                      // Name
                      Text(
                        'Name',
                        style: getSemiBoldStyle(
                          fontSize: FontSize.s16,
                          color: AppColors.textPrimaryColor,
                        ),
                      ),
                      const SizedBox(height: AppSize.s8),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Cardholder Name',
                          hintStyle: getRegularStyle(
                            fontSize: FontSize.s16,
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ),
                    ] else ...[
                      // Cash payment instructions
                      Container(
                        padding: const EdgeInsets.all(AppPadding.p16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(AppSize.s8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cash Payment Instructions',
                              style: getSemiBoldStyle(
                                fontSize: FontSize.s16,
                                color: AppColors.textPrimaryColor,
                              ),
                            ),
                            const SizedBox(height: AppSize.s8),
                            Text(
                              'Please pay the amount in cash at the clinic reception before your appointment.',
                              style: getRegularStyle(
                                fontSize: FontSize.s14,
                                color: AppColors.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSize.s32),
                    // Pay Now button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Process payment
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(_isCardPayment
                                  ? 'Processing card payment...'
                                  : 'Cash payment confirmed'),
                              backgroundColor: AppColors.successColor,
                            ),
                          );
                          // Navigate back to previous screen after payment
                          Future.delayed(const Duration(seconds: 2), () {
                            Navigator.pop(context);
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: AppPadding.p16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSize.s8),
                          ),
                        ),
                        child: Text(
                          'Pay Now',
                          style: getBoldStyle(
                            fontSize: FontSize.s18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
