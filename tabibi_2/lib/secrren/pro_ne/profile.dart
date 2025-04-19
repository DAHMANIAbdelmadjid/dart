import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/app/core/style_constants.dart';
import 'package:tabibi_2/app/core/styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          'Profile',
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
              const SizedBox(height: AppSize.s20),
              // Profile Image
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      const AssetImage('assets/images/profile.png'),
                  backgroundColor: AppColors.secondaryColor,
                ),
              ),
              const SizedBox(height: AppSize.s16),
              // User Name
              Text(
                'John Doe William',
                style: getBoldStyle(
                  fontSize: FontSize.s22,
                  color: AppColors.textPrimaryColor,
                ),
              ),
              const SizedBox(height: AppSize.s30),
              // Menu Items
              _buildMenuItem(
                icon: Icons.history,
                title: 'History',
                onTap: () {
                  // Navigate to history screen
                },
                iconColor: Colors.teal.shade200,
              ),
              _buildMenuItem(
                icon: Icons.person,
                title: 'Personal Detailes',
                onTap: () {
                  // Navigate to personal details screen
                },
                iconColor: Colors.teal.shade200,
              ),
              _buildMenuItem(
                icon: Icons.location_on,
                title: 'Location',
                onTap: () {
                  // Navigate to location screen
                },
                iconColor: Colors.teal.shade200,
              ),
              _buildMenuItem(
                icon: Icons.payment,
                title: 'Payment Method',
                onTap: () {
                  // Navigate to payment method screen
                },
                iconColor: Colors.teal.shade200,
              ),
              _buildMenuItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  // Navigate to settings screen
                },
                iconColor: Colors.teal.shade200,
              ),
              _buildMenuItem(
                icon: Icons.help,
                title: 'Help',
                onTap: () {
                  // Navigate to help screen
                },
                iconColor: Colors.teal.shade200,
              ),
              _buildMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  // Handle logout
                },
                iconColor: Colors.teal.shade200,
                showArrow: false,
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

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color iconColor,
    bool showArrow = true,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSize.s12),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p16,
            vertical: AppPadding.p12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSize.s12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon Container
              Container(
                padding: const EdgeInsets.all(AppPadding.p8),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppSize.s8),
                ),
                child: Icon(icon, color: AppColors.primaryColor, size: 24),
              ),
              const SizedBox(width: AppSize.s16),
              // Title
              Expanded(
                child: Text(
                  title,
                  style: getSemiBoldStyle(
                    fontSize: FontSize.s16,
                    color: AppColors.textPrimaryColor,
                  ),
                ),
              ),
              // Arrow Icon
              if (showArrow)
                const Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.textSecondaryColor,
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
