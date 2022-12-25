// ignore_for_file: camel_case_types

import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:onboarding_screen/models/get_data_cart_model.dart';
import 'package:onboarding_screen/modules/login/bloc/cubit.dart';
import 'package:onboarding_screen/modules/login/bloc/states.dart';

class Cart_Screen extends StatelessWidget {
  const Cart_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        builder: (context, state) {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Cart",
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: FadeInRightBig(
              delay: const Duration(milliseconds: 100),
              child: ConditionalBuilder(
                  condition:
                      cubit.getDataCartModel!.data!.cart_items.isNotEmpty,
                  builder: (context) {
                    return ListView.separated(
                        itemBuilder: (context, index) {
                          return buildCart(
                              cubit.getDataCartModel!.data!.cart_items[index],
                              context);
                        },
                        separatorBuilder: (context, index) => const SizedBox(),
                        itemCount:
                            cubit.getDataCartModel!.data!.cart_items.length);
                  },
                  fallback: (context) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset('assets/images/2.json',
                                width: 220.0, height: 220.0),
                            const Text(
                              "Cart is Empty",
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 22.0),
                            ),
                          ],
                        ),
                      )),
            ),
          );
        },
        listener: (context, state) {});
  }

  Widget buildCart(CartItemModel model, context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Image(
              width: 150.0,
              height: 150.0,
              image: NetworkImage(model.product!.image!),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model.product!.name}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${model.product!.price}",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              50.0,
                            ),
                            color: Colors.black),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            ShopLoginCubit.get(context)
                                .postCart(productId: model.product!.id!);
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
