import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/modules/home/home.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';
import 'package:onboarding_screen/modules/login/login.dart';
import 'package:onboarding_screen/modules/onboarding/onboarding.dart';
import 'package:onboarding_screen/modules/register/bloc/cubit.dart';
import 'package:onboarding_screen/modules/splash_screen/splash_screen.dart';
import 'package:onboarding_screen/shared/component/constants.dart';
import 'package:onboarding_screen/shared/network/local/cache_helper.dart';
import 'package:onboarding_screen/shared/observer/observer.dart';
import 'package:onboarding_screen/shared/network/remote/dio.dart';
import 'shared/style/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Dio_Helper.init();
  await Cache_Helper.init();

  dynamic onboadring = Cache_Helper.getData(key: 'onBoarding');
  token = Cache_Helper.getData(key: 'token');
  if (onboadring != null) {
    if (token != null) {
      widgett = const Home_Screen();
    } else {
      widgett = Login_Screen();
    }
  } else {
    widgett = const OnBoarding_Screen();
  }
  runApp(MyApp(
    widget: widgett!,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.widget});
  // This widget is the root of your application.

  final Widget widget;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopLoginCubit()
            ..homeData()
            ..categoryData()
            ..favoriteData()..getDataUser(),
        ),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
      ],
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
          return MaterialApp(
            title: 'OnBoarding',
            theme: ThemeData(
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: TextStyle(
                  color: Colors.deepOrange,
                ),
                selectedLabelStyle: TextStyle(
                  color: Colors.deepOrange,
                ),
                unselectedIconTheme: IconThemeData(
                  color: Colors.grey,
                ),
                selectedIconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    foregroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
              ),
              primarySwatch: defaultColor,
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                  bodyText2: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  bodyText1: TextStyle(
                    color: Colors.black,
                    fontSize: 30.0,
                  )),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black)),
            ),
            darkTheme: ThemeData(
              primarySwatch: defaultColor,
              primaryIconTheme: const IconThemeData(color: Colors.white),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.deepOrange),
                  ),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 0.451),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    foregroundColor:
                        MaterialStateProperty.all(Colors.deepOrange),
                    backgroundColor: MaterialStateProperty.all(Colors.black)),
              ),
              textTheme: const TextTheme(
                  subtitle1: TextStyle(
                    color: Colors.white,
                  ),
                  subtitle2: TextStyle(
                    color: Colors.white,
                  ),
                  bodyText2: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                  bodyText1: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                  ),
                  headline5: TextStyle(color: Colors.white)),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black45,
                elevation: 0,
              ),
            ),
            themeMode: ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: Splash_Screen(),
          );
        },
        listener: ((context, state) {}),
      ),
    );
  }
}
