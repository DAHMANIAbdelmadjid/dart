import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:tabibi_2/app/core/app_colors.dart';
import 'package:tabibi_2/secrren/doctor_profile.dart';
import 'package:tabibi_2/secrren/jone.dart';
import 'package:tabibi_2/secrren/sarch_doctor.dart';
import 'package:tabibi_2/secrren/telegram_and_whatsapp.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.primaryColor,
        items: const [
          Icon(
            Icons.home,
            color: AppColors.primaryColor,
          ),
          Icon(
            Icons.access_time,
            color: AppColors.primaryColor,
          ),
          Icon(
            Icons.message_outlined,
            color: AppColors.primaryColor,
          ),
          Icon(
            Icons.person,
            color: AppColors.primaryColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      body: selectedIndex == 0
          ? const JoneScreen()
          : selectedIndex == 1
              ? const SearchDoctor()
              : selectedIndex == 2
                  ? const TelegramAndWhatsapp()
                  : const DoctorProfile(),
    );
  }
}
