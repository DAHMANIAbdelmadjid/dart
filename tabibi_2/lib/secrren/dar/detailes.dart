import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';

class Detailes extends StatelessWidget {
  const Detailes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointment',
          style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      child: Image.asset(
                        'assets/images/doctor.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: AppSize.s16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Dr. Upul',
                                style: getBoldStyle(
                                  fontSize: FontSize.s20,
                                  color: AppColors.textPrimaryColor,
                                ),
                              ),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.all(AppPadding.p8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Icon(Icons.chat_bubble_outline, color: AppColors.primaryColor, size: 20),
                              ),
                              SizedBox(width: AppSize.s8),
                              Container(
                                padding: EdgeInsets.all(AppPadding.p8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Icon(Icons.call, color: AppColors.primaryColor, size: 20),
                              ),
                              SizedBox(width: AppSize.s8),
                              Container(
                                padding: EdgeInsets.all(AppPadding.p8),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey.shade300),
                                ),
                                child: Icon(Icons.videocam, color: AppColors.primaryColor, size: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: AppSize.s4),
                          Text(
                            'Denteeth',
                            style: getRegularStyle(
                              fontSize: FontSize.s14,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: AppSize.s12),
                          Row(
                            children: [
                              Text(
                                'Payment',
                                style: getSemiBoldStyle(
                                  fontSize: FontSize.s16,
                                  color: AppColors.textPrimaryColor,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '120.00',
                                style: getBoldStyle(
                                  fontSize: FontSize.s18,
                                  color: AppColors.successColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppSize.s20),
            Text(
              'Details',
              style: getBoldStyle(
                fontSize: FontSize.s18,
                color: AppColors.textPrimaryColor,
              ),
            ),
            SizedBox(height: AppSize.s8),
            Text(
              'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque.',
              style: getRegularStyle(
                fontSize: FontSize.s14,
                color: AppColors.textSecondaryColor,
              ),
            ),
            SizedBox(height: AppSize.s20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Working Hours',
                  style: getBoldStyle(
                    fontSize: FontSize.s18,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: getRegularStyle(
                      fontSize: FontSize.s14,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.s8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTimeButton('10.00 AM', isSelected: true),
                _buildTimeButton('11.00 AM'),
                _buildTimeButton('12.00 PM'),
              ],
            ),
            SizedBox(height: AppSize.s20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date',
                  style: getBoldStyle(
                    fontSize: FontSize.s18,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'See All',
                    style: getRegularStyle(
                      fontSize: FontSize.s14,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.s8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateButton('Sun 4', isSelected: true),
                _buildDateButton('Mon 5'),
                _buildDateButton('Tue 6'),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: AppPadding.p16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                ),
                child: Text(
                  'Book an Appointment',
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
    );
  }
  
  Widget _buildTimeButton(String time, {bool isSelected = false}) {
    return Container(
      width: 100,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
          foregroundColor: isSelected ? Colors.white : AppColors.textPrimaryColor,
          elevation: 0,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
        ),
        child: Text(time),
      ),
    );
  }
  
  Widget _buildDateButton(String date, {bool isSelected = false}) {
    return Container(
      width: 100,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryColor : Colors.white,
          foregroundColor: isSelected ? Colors.white : AppColors.textPrimaryColor,
          elevation: 0,
          side: BorderSide(color: Colors.grey.shade300),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s8),
          ),
        ),
        child: Text(date),
      ),
    );
  }
}
