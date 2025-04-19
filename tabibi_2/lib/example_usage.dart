import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExampleSvgUsage extends StatelessWidget {
  const ExampleSvgUsage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Correct way to reference the SVG
    return SvgPicture.asset(
      'assets/icon/undraw_doctor_aum2.svg',
      // other parameters...
    );

    // NOT like this (which would cause the error you're seeing):
    // return SvgPicture.asset('assets/assets/icon/undraw_doctor_aum2.svg');
  }
}
