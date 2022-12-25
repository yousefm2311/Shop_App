// ignore_for_file: camel_case_types

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/models/category_model.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';

class Categories_Screen extends StatelessWidget {
  const Categories_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: ((context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: ListView.separated(
                itemBuilder: (context, index) =>
                    buildCategories(cubit.categoryModel!.data!.data[index]),
                separatorBuilder: (context, index) => const SizedBox(
                      height: 5.0,
                    ),
                itemCount: cubit.categoryModel!.data!.data.length),
          );
        }),
        listener: (context, state) {});
  }

  Widget buildCategories(CategoryDataList categoryDataList) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: FadeInDown(
          delay: const Duration(milliseconds: 200),
          child: Row(
            children: [
              Image(
                width: 120,
                height: 120,
                image: NetworkImage('${categoryDataList.image}'),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                "${categoryDataList.name}",
                style: const TextStyle(fontSize: 20.0, color: Colors.black),
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios))
            ],
          ),
        ),
      );
}
