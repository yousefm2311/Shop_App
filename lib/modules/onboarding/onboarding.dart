// ignore_for_file: camel_case_types, unnecessary_string_interpolations

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:onboarding_screen/modules/login/login.dart';
import 'package:onboarding_screen/shared/component/component.dart';
import 'package:onboarding_screen/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class onboardModel {
  final String title;
  final String body;
  final String image;

  onboardModel(this.title, this.body, this.image);
}

class OnBoarding_Screen extends StatefulWidget {
  const OnBoarding_Screen({super.key});
  @override
  State<OnBoarding_Screen> createState() => _OnBoarding_ScreenState();
}

class _OnBoarding_ScreenState extends State<OnBoarding_Screen> {
  void submit() {
    Cache_Helper.saveData(key: 'onBoarding', value: true).then((value) {
      defaultNavigator(context, Login_Screen());
    });
  }

  var onboardingController = PageController();
  List<onboardModel> onboarding = [
    onboardModel(
        "Track Your Crypto",
        'Track and buy cryptocurrencies at real value, trade with ease and confidence in one safe and fast application',
        'assets/images/1.png'),
    onboardModel(
        "Explore Best Coins",
        'All crypto go through a rigorous evaluation processand are compared to thousands of other crypto projects',
        'assets/images/2.png'),
    onboardModel(
        "Fast Optimization",
        'Ongoing optimization of protofolios market conditions and adjustment of cryptocurrency selection',
        'assets/images/3.png'),
  ];
  bool isLast = false;
  String skip = 'Skip';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
                onPressed: () {
                  submit();
                },
                child: const Text('SKIP'))
          ],
        ),
        body: FadeInUpBig(
          delay: const Duration(milliseconds: 200),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                SmoothPageIndicator(
                  controller: onboardingController,
                  count: onboarding.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.deepOrange,
                    dotHeight: 10,
                    dotWidth: 10,
                    dotColor: Colors.grey,
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    onPageChanged: (int index) {
                      if (index == onboarding.length - 1) {
                        setState(() {
                          isLast = true;
                        });
                      } else {
                        setState(() {
                          isLast = false;
                        });
                      }
                    },
                    controller: onboardingController,
                    itemBuilder: (context, index) =>
                        defaultOnBoarding(onboarding[index]),
                    itemCount: onboarding.length,
                  ),
                ),
                Container(
                  width: isLast ? 150 : 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.grey[800],
                  ),
                  child: MaterialButton(
                    height: 50,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        onboardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: Text(
                      isLast ? 'Next' : '$skip',
                      style: const TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
              ],
            ),
          ),
        ));
  }

  Widget defaultOnBoarding(onboardModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          Text(
            '${model.title}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            '${model.body}',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      );
}
