import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      builder: ((context, state) {
        ShopLoginCubit cubit = ShopLoginCubit.get(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.production_quantity_limits_sharp),
                    label: 'Product'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.category), label: 'Category'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.settings,
                    ),
                    label: 'Settings'),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (int index) {
                cubit.changeBottomNavi(index);
              }),
        );
      }),
      listener: ((context, state) {}),
    );
  }
}
