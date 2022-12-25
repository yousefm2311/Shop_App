// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:onboarding_screen/shared/component/component.dart';

import '../../shared/component/constants.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({super.key});

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => widget));
      defaultNavigator(context,widgett);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(
          'assets/images/3.json',
        ),
      ),
    );
  }
}
