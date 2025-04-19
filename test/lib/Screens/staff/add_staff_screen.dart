import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({Key? key}) : super(key: key);

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _staffIdController = TextEditingController();
  DateTime? _vignettesDate;
  DateTime? _scannerDate;
  DateTime? _assuranceDate;
  String? _role;
  String? _statut;
  String? _designation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add a New Staff',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildFormSection(
                  label: 'Name',
                  child: TextFormField(
                    controller: _nameController,
                    decoration: _buildInputDecoration('Enter first name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                ),
                _buildFormSection(
                  label: "L'assurance",
                  child: _buildDateField(
                    value: _assuranceDate,
                    onTap: () => _selectDate(context, 'assurance'),
                  ),
                ),
                _buildFormSection(
                  label: 'vignettes',
                  child: _buildDateField(
                    value: _vignettesDate,
                    onTap: () => _selectDate(context, 'vignettes'),
                  ),
                ),
                _buildFormSection(
                  label: 'Statut',
                  child: _buildDropdown(
                    hint: 'Select role',
                    value: _statut,
                    items: ['Active', 'Inactive', 'On Leave'],
                    onChanged: (value) => setState(() => _statut = value),
                  ),
                ),
                _buildFormSection(
                  label: 'Scanner',
                  child: _buildDateField(
                    value: _scannerDate,
                    onTap: () => _selectDate(context, 'scanner'),
                  ),
                ),
                _buildFormSection(
                  label: 'Carte grise du véhicule',
                  child: _buildImageUpload(),
                ),
                _buildFormSection(
                  label: 'Role',
                  child: _buildDropdown(
                    hint: 'Select role',
                    value: _role,
                    items: ['Admin', 'Manager', 'Employee'],
                    onChanged: (value) => setState(() => _role = value),
                  ),
                ),
                _buildFormSection(
                  label: 'Designation',
                  child: _buildDropdown(
                    hint: 'Select designation',
                    value: _designation,
                    items: ['Senior', 'Junior', 'Intern'],
                    onChanged: (value) => setState(() => _designation = value),
                  ),
                ),
                _buildFormSection(
                  label: 'Staff ID',
                  child: TextFormField(
                    controller: _staffIdController,
                    decoration: _buildInputDecoration('Staff ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a staff ID';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Implement form submission
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF246BFD),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Ajoutes une voiture',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        child,
        const SizedBox(height: 16),
      ],
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black26),
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  Widget _buildDateField({
    required DateTime? value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value != null ? DateFormat('dd/MM/yyyy').format(value) : 'DD/MM/YYYY',
              style: TextStyle(
                color: value != null ? Colors.black87 : Colors.black26,
              ),
            ),
            Icon(Icons.calendar_today, size: 20, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required void Function(String?) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(hint, style: const TextStyle(color: Colors.black26)),
        items: items.map((item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        )).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildImageUpload() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          "Entrez l'image.",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, String field) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        switch (field) {
          case 'vignettes':
            _vignettesDate = picked;
            break;
          case 'scanner':
            _scannerDate = picked;
            break;
          case 'assurance':
            _assuranceDate = picked;
            break;
        }
      });
    }
  }
}
