// ignore_for_file: must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/models/favorite_data_model.dart';
import 'package:onboarding_screen/models/home_model.dart';
import 'package:onboarding_screen/models/search_model.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';
import 'package:onboarding_screen/shared/component/component.dart';
import 'package:onboarding_screen/shared/style/colors.dart';

class Search_Screen extends StatelessWidget {
  Search_Screen({super.key});

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                      text: "Search",
                      controller: searchController,
                      context: context,
                      onchange: (String? value) {
                        cubit.searchData(text: searchController.text);
                      }),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (state is ShopSearchLoadingSate)
                    LinearProgressIndicator(
                      color: Colors.blue,
                      backgroundColor: Colors.blue.shade100,
                    ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  if (state is ShopSearchSuccessSate)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return buildSearch(
                              cubit.searchModel!.data!.data[index], context);
                        },
                        separatorBuilder: ((context, index) =>
                            const SizedBox()),
                        itemCount: 2,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget buildSearch(SearchModelList model, context) => Column(
        children: [
          Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                width: 120.0,
                height: 120.0,
                image: NetworkImage(model.image!),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${model.name}",
                      style:
                          const TextStyle(color: Colors.black, fontSize: 20.0),
                      maxLines: 2,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${model.price} EGP',
                          style: TextStyle(
                              color: Colors.grey.shade900, fontSize: 14.0),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      );
}
