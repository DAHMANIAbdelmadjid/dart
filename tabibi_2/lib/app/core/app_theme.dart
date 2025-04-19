import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    disabledColor: AppColors.backgroundColor,
    splashColor: AppColors.primaryColor.withOpacity(0.8),
    cardTheme: CardTheme(
      color: AppColors.secondaryColor,
      shadowColor: AppColors.textSecondaryColor.withOpacity(0.2),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
    ),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: AppColors.secondaryColor,
      elevation: 0,
      titleTextStyle: getBoldStyle(
        fontSize: AppManger.m14,
        color: AppColors.primaryColor,
      ),
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppManger.m10),
      ),
      buttonColor: AppColors.primaryColor,
      disabledColor: AppColors.primaryColor.withOpacity(0.8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(AppPadding.p16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppManger.m10),
        ),
        textStyle: getBoldStyle(
          fontSize: AppManger.m22,
          color: Colors.white,
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p10),
      hintStyle: getRegularStyle(
        fontSize: FontSize.s18,
        color: AppColors.textPrimaryColor,
      ),
      labelStyle: getRegularStyle(
        fontSize: FontSize.s18,
        color: AppColors.textPrimaryColor,
      ),
      errorStyle: getRegularStyle(
        fontSize: FontSize.s18,
        color: AppColors.errorColor,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.textSecondaryColor.withOpacity(0.8),
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.errorColor,
          width: AppSize.s1_5,
        ),
        borderRadius: BorderRadius.circular(AppSize.s10),
      ),
    ),
  );
}
