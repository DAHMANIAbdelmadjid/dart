import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Notification',
          style: getBoldStyle(
            fontSize: FontSize.s20,
            color: AppColors.primaryColor,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            children: [
              // New Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New',
                    style: getBoldStyle(
                      fontSize: FontSize.s18,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle mark all as read
                    },
                    child: Text(
                      'Mark All',
                      style: getSemiBoldStyle(
                        fontSize: FontSize.s14,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s16),
              // Notification Items
              _buildNotificationItem(
                title: 'April 2023',
                message: 'Lorem ipsum dolor sit amet,adipiscing elit.',
                time: '15 Min',
              ),
              const SizedBox(height: AppSize.s12),
              _buildNotificationItem(
                title: 'April 2023',
                message: 'Lorem ipsum dolor sit amet,adipiscing elit.',
                time: '15 Min',
              ),
              const SizedBox(height: AppSize.s12),
              _buildNotificationItem(
                title: 'April 2023',
                message: 'Lorem ipsum dolor sit amet,adipiscing elit.',
                time: '15 Min',
              ),
              const SizedBox(height: AppSize.s12),
              _buildNotificationItem(
                title: 'April 2023',
                message: 'Lorem ipsum dolor sit amet,adipiscing elit.',
                time: '15 Min',
              ),
              const SizedBox(height: AppSize.s12),
              _buildNotificationItem(
                title: 'April 2023',
                message: 'Lorem ipsum dolor sit amet,adipiscing elit.',
                time: '15 Min',
              ),
              const SizedBox(height: AppSize.s12),
              _buildNotificationItem(
                title: 'April 2023',
                message: 'Lorem ipsum dolor sit amet,adipiscing elit.',
                time: '15 Min',
              ),
              const SizedBox(height: AppSize.s24),
              // See All Button
              Center(
                child: TextButton(
                  onPressed: () {
                    // Handle see all notifications
                  },
                  child: Text(
                    'See All',
                    style: getBoldStyle(
                      fontSize: FontSize.s16,
                      color: AppColors.textPrimaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: 3, // Profile tab is selected
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String message,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Notification Bell Icon
          Container(
            margin: const EdgeInsets.symmetric(vertical: AppSize.s4),
            child: const Icon(
              Icons.notifications_none,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: AppSize.s12),
          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: getBoldStyle(
                        fontSize: FontSize.s16,
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                    Text(
                      time,
                      style: getRegularStyle(
                        fontSize: FontSize.s12,
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSize.s4),
                Text(
                  message,
                  style: getRegularStyle(
                    fontSize: FontSize.s14,
                    color: AppColors.textSecondaryColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


























































