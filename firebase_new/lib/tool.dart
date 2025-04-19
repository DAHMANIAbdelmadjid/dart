import 'package:flutter/material.dart';

class TextFormFieldUse extends StatelessWidget {
  final TextEditingController myController;
  final String hintTextField;
  final bool obscureTextbool;
  final String? Function(String?)? validator;
  const TextFormFieldUse({
    super.key,
    required this.hintTextField,
    required this.myController,
    required this.obscureTextbool,
    required this.validator, // Use the controller passed from the parent
// Use the controller passed from the parent
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureTextbool,
      controller: myController, // Make sure the controller is used here
      cursorColor: const Color(0xffFD7DA0),
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[50],
        hintText: hintTextField,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(70)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(70)),
          borderSide: BorderSide(color: Color(0xffFD7DA0)),
        ),
      ),
    );
  }
}
