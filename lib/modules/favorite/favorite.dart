// ignore_for_file: camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_screen/models/favorite_data_model.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';

import '../../shared/style/colors.dart';
import '../login/bloc/states.dart';

class Favorite_Screen extends StatelessWidget {
  const Favorite_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
      builder: ((context, state) {
        ShopLoginCubit cubit = ShopLoginCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
              condition: state is! ShopGetLoadingFavoriteSuccessState,
              builder: (context) => cubit.favoriteModel!.data!.data.length != 0
                  ? ListView.separated(
                      itemBuilder: (context, index) => buildGridView(
                          cubit.favoriteModel!.data!.data[index], context),
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10.0,
                          ),
                      itemCount: cubit.favoriteModel!.data!.data.length)
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text('💔', style: TextStyle(fontSize: 40.0)),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const Text("Not Favorite",
                              style: TextStyle(fontSize: 22.0)),
                        ],
                      ),
                    ),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  )),
        );
      }),
      listener: ((context, state) {}),
    );
  }

  Widget buildGridView(FavoriteDataList model, context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          width: 150,
          height: 100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    width: 175,
                    height: 175,
                    image: NetworkImage('${model.product!.image}'),
                  ),
                  if (model.product!.discount != 0)
                    Container(
                        padding: const EdgeInsets.all(3.0),
                        color: Colors.red.withOpacity(.8),
                        child: const Text(
                          'DISCOUNT',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )),
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model.product!.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        Text(
                          '${model.product!.price}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.deepOrange,
                          ),
                        ),
                        const SizedBox(
                          width: 3.0,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            '${model.product!.old_price}',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontSize: 12,
                            ),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: ShopLoginCubit.get(context)
                                  .favoriteMap[model.product!.id]!
                              ? defaultColor
                              : Colors.grey,
                          radius: 16.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              ShopLoginCubit.get(context)
                                  .changeFavorite(model.product!.id!);
                            },
                            icon: const Icon(
                              Icons.favorite_border_sharp,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
