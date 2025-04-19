import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';

class CardListDoctor extends StatelessWidget {
  final String doctorName;

  const CardListDoctor({
    super.key,
    required this.doctorName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p12),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.secondaryColor,
              child: Text(
                doctorName[0],
                style: getBoldStyle(
                  fontSize: FontSize.s20,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doctorName,
                    style: getSemiBoldStyle(
                      fontSize: FontSize.s16,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  const SizedBox(height: AppSize.s4),
                  Text(
                    'Specialist',
                    style: getRegularStyle(
                      fontSize: FontSize.s14,
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
