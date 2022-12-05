// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:onboarding_screen/modules/login/login.dart';
import 'package:onboarding_screen/shared/component/component.dart';
import 'package:onboarding_screen/shared/network/local/cache_helper.dart';

class Settings_Screen extends StatelessWidget {
  const Settings_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            Cache_Helper.removeToken(key: 'token').then((value) {
              if (value) {
                defaultNavigator(context, Login_Screen());
              }
            });
          },
          child: const Text(
            'Logout',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
      ),
    );
  }
}
