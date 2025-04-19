import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';
import 'package:tabibi_2/generated/l10n.dart';
import 'package:tabibi_2/widgets/card_list_doctor.dart';

class ListDoctor extends StatelessWidget {
  const ListDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    var listDoctor = [
      "Ahmed",
      "Mohamed",
      "Ali",
      "Hassan",
      "Khalid",
      "Maged",
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).doctors,
          style: getBoldStyle(
            fontSize: FontSize.s20,
            color: AppColors.textPrimaryColor,
          ),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: S.of(context).searchDoctor,
                hintStyle: getRegularStyle(
                  fontSize: FontSize.s16,
                  color: AppColors.textSecondaryColor,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: AppColors.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Expanded(
              child: ListView.builder(
                itemCount: listDoctor.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: AppPadding.p8),
                  child: CardListDoctor(
                    doctorName: listDoctor[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
