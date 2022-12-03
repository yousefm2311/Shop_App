import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
          child: Text(
            'Logout',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
      ),
    );
  }
}
