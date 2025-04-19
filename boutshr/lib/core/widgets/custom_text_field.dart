import 'package:flutter/material.dart';
import 'package:boutshr/core/constants/app_colors.dart';
import 'package:boutshr/core/constants/style_constants.dart';
import 'package:boutshr/core/utils/styles.dart';

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
            hintText: "${S.of(context).enter} $text",
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
