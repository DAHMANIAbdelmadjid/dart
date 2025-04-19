import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/generated/l10n.dart';

class CardImageAndProFile extends StatelessWidget {
  const CardImageAndProFile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        semanticContainer: true,
        borderOnForeground: true,
        child: Card(
            color: AppColors.secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                          'https://via.placeholder.com/150',
                        ),
                      ),
                      const SizedBox(width: AppSize.s10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            S.of(context).welcome,
                            style: getRegularStyle(
                              color: AppColors.textSecondaryColor,
                              fontSize: FontSize.s14,
                            ),
                          ),
                          Text(
                            'John Doe William',
                            style: getSemiBoldStyle(
                              color: AppColors.textPrimaryColor,
                              fontSize: FontSize.s16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_none),
                        color: AppColors.textPrimaryColor,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: AppSize.s10,
                          height: AppSize.s10,
                          decoration: const BoxDecoration(
                            color: AppColors.errorColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
