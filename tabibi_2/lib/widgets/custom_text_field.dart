import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.text,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: getSemiBoldStyle(
            fontSize: FontSize.s16,
            color: AppColors.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppSize.s8),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          keyboardType: keyboardType,
          validator: validator,
          style: getRegularStyle(
            fontSize: FontSize.s16,
            color: AppColors.textPrimaryColor,
          ),
          decoration: InputDecoration(
            hintText: "Enter $text",
            hintStyle: getRegularStyle(
              fontSize: FontSize.s16,
              color: AppColors.textSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
