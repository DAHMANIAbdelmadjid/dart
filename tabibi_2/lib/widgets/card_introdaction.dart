import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/assets.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardIntrodaction extends StatelessWidget {
  const CardIntrodaction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
          semanticContainer: true,
          borderOnForeground: true,
          child: Card(
            color: AppColors.secondaryColor,
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(S.of(context).welcome,
                          style: getBoldStyle(
                            fontSize: FontSize.s16,
                            color: AppColors.textPrimaryColor,
                          )),
                      const SizedBox(
                        height: AppSize.s4,
                      ),
                      Text(S.of(context).introTest,
                          style: getBoldStyle(
                            fontSize: FontSize.s14,
                            color: AppColors.textPrimaryColor,
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  SizedBox(
                      width: AppSize.s200,
                      height: AppSize.s200,
                      child: SvgPicture.asset(AppAssets.doctor2))
                ],
              ),
            ),
          )),
    );
  }
}
