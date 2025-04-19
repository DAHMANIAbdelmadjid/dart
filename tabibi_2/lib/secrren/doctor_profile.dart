import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/generated/l10n.dart';

class DoctorProfile extends StatelessWidget {
  const DoctorProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).doctorProfile,
          style: getBoldStyle(
            fontSize: FontSize.s20,
            color: AppColors.textPrimaryColor,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.secondaryColor,
                  child: Text(
                    'D',
                    style: getBoldStyle(
                      fontSize: FontSize.s20,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s16),
              Center(
                child: Text(
                  'Dr. John Doe',
                  style: getBoldStyle(
                    fontSize: FontSize.s24,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Center(
                child: Text(
                  'Cardiologist',
                  style: getRegularStyle(
                    fontSize: FontSize.s16,
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s24),
              Text(
                'About',
                style: getSemiBoldStyle(
                  fontSize: FontSize.s18,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: getRegularStyle(
                  fontSize: FontSize.s14,
                  color: AppColors.textSecondaryColor,
                ),
              ),
              const SizedBox(height: AppSize.s24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: AppPadding.p12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    S.of(context).bookAppointment,
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}